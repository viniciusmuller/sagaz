defmodule FlightServiceWeb.FlightController do
  use FlightServiceWeb, :controller
  use OpenApiSpex.ControllerSpecs
  alias OpenApiSpex.Schema

  alias FlightService.Flights
  alias FlightService.Flights.{Flight, Plane}
  alias FlightServiceWeb.ApiSchemas

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

  tags(["Flights"])

  operation(:index,
    summary: "List flights",
    responses: [
      ok: {"Flight", "application/json", %Schema{type: :array, items: ApiSchemas.FlightResponse}}
    ]
  )

  operation(:create,
    summary: "Book flight",
    request_body:
      {"The flight attributes", "application/json", ApiSchemas.FlightRequest, required: true},
    responses: [
      created: {"Flight", "application/json", ApiSchemas.FlightResponse}
    ]
  )

  operation(:show,
    summary: "Show flight",
    parameters: [
      id: [
        in: :path,
        type: :string,
        description: "Flight ID",
        required: true
      ]
    ],
    responses: [
      ok: {"User", "application/json", ApiSchemas.FlightResponse}
    ]
  )

  operation(:update,
    summary: "Update a flight",
    parameters: [
      id: [in: :path, description: "Flight ID", type: :string]
    ],
    request_body: {"Flight params", "application/json", ApiSchemas.FlightRequest, required: true},
    responses: [
      ok: {"Flight response", "application/json", ApiSchemas.FlightResponse}
    ]
  )

  operation(:delete,
    summary: "Unbook a flight",
    parameters: [
      id: [in: :path, description: "Flight ID", type: :string]
    ],
    responses: [
      no_content: "Succesfully deleted"
    ]
  )
end
