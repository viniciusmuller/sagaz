defmodule FlightServiceWeb.FlightController do
  use FlightServiceWeb, :controller
  use PhoenixSwagger

  alias FlightService.Flights
  alias FlightService.Flights.{Flight, Plane}

  action_fallback FlightServiceWeb.FallbackController

  def index(conn, _params) do
    flights = Flights.list_flights()
    render(conn, :index, flights: flights)
  end

  def create(conn, %{"flight" => flight_params}) do
    with {:ok, %Plane{}} <- Flights.fetch_plane(flight_params["plane_id"]),
         {:ok, %Flight{} = flight} <- Flights.book_flight(flight_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/flights/#{flight}")
      |> render(:show, flight: flight)
    end
  end

  def show(conn, %{"id" => id}) do
    flight = Flights.get_flight!(id)
    render(conn, :show, flight: flight)
  end

  def update(conn, %{"id" => id, "flight" => flight_params}) do
    flight = Flights.get_flight!(id)

    with {:ok, %Flight{} = flight} <- Flights.update_flight(flight, flight_params) do
      render(conn, :show, flight: flight)
    end
  end

  def delete(conn, %{"id" => id}) do
    flight = Flights.get_flight!(id)

    with {:ok, %Flight{}} <- Flights.unbook_flight(flight) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      Flight:
        swagger_schema do
          title("Flight")
          description("Represents a booked flight")

          properties do
            depart_time(:utc_datetime, "Flight depart time", required: true)
            arrival_time(:utc_datetime, "Flight expected arrival time", required: true)
            from(:string, "Source airport IATA code", required: true)
            to(:string, "Destination airport IATA code", required: true)
            plane_id(:string, "Flight plane's id", required: true)
          end

          example(%{
            depart_time: "2023-04-05T21:00:00Z",
            arrival_time: "2023-04-05T23:00:00Z",
            from: "POA",
            to: "GRU",
            plane_id: "41c2fd5e-d77a-4bba-bdd6-1ab88f308a0e"
          })
        end,
      FlightRequest:
        swagger_schema do
          title("FlightRequest")
          description("POST body for creating a flight")
          property(:plane, Schema.ref(:Flight), "The flight details")
        end,
      FlightResponse:
        swagger_schema do
          title("FlightResponse")
          description("Response schema for single flight")
          property(:data, Schema.ref(:Flight), "The flight details")
        end,
      FlightsResponse:
        swagger_schema do
          title("FlightsResponse")
          description("Response schema for multiple flights")
          property(:data, Schema.array(:Flight), "The flights details")
        end
    }
  end

  swagger_path(:index) do
    summary("List flights")
    description("Lists existing flights")

    response(200, "OK", Schema.ref(:FlightsResponse))
  end

  swagger_path(:create) do
    summary("Book flight")
    description("Books a flight")

    parameter(:plane, :body, Schema.ref(:FlightRequest), "The flight details")
    response(201, "Created", Schema.ref(:FlightResponse))
  end

  swagger_path(:show) do
    summary("Show flight")
    description("Show a flight by ID")

    parameter(:id, :path, :string, "Flight ID",
      required: true,
      example: "f3cd3f9b-9019-471b-b2e9-02c475fe2bbd"
    )

    response(200, "OK", Schema.ref(:FlightResponse))
  end

  swagger_path(:update) do
    summary("Update flight")
    description("Update all attributes of a flight")

    parameter(:id, :path, :string, "Flight ID",
      required: true,
      example: "f3cd3f9b-9019-471b-b2e9-02c475fe2bbd"
    )

    parameter(:plane, :body, Schema.ref(:FlightRequest), "The flight details")
    response(200, "Updated", Schema.ref(:FlightResponse))
  end

  swagger_path(:delete) do
    summary("Unbook Flight")
    description("Unbook a flight by ID")

    parameter(:id, :path, :string, "Flight ID", required: true)
    response(204, "No Content - Unbooked Successfully")
  end
end
