defmodule FlightServiceWeb.PlaneController do
  use FlightServiceWeb, :controller
  use PhoenixSwagger

  alias FlightService.Flights
  alias FlightService.Flights.Plane

  action_fallback FlightServiceWeb.FallbackController

  def index(conn, _params) do
    planes = Flights.list_planes()
    render(conn, :index, planes: planes)
  end

  def create(conn, %{"plane" => plane_params}) do
    with {:ok, %Plane{} = plane} <- Flights.create_plane(plane_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/planes/#{plane}")
      |> render(:show, plane: plane)
    end
  end

  def show(conn, %{"id" => id}) do
    plane = Flights.get_plane!(id)
    render(conn, :show, plane: plane)
  end

  def update(conn, %{"id" => id, "plane" => plane_params}) do
    plane = Flights.get_plane!(id)

    with {:ok, %Plane{} = plane} <- Flights.update_plane(plane, plane_params) do
      render(conn, :show, plane: plane)
    end
  end

  def delete(conn, %{"id" => id}) do
    plane = Flights.get_plane!(id)

    with {:ok, %Plane{}} <- Flights.delete_plane(plane) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      Plane:
        swagger_schema do
          title("Plane")
          description("Represents a specific plane")

          properties do
            uuid(:string, "The ID of the plane")
            name(:string, "The name of the plane", required: true)
            capacity(:integer, "Plane's max capacity", required: true)
          end

          example(%{name: "F22", capacity: 15})
        end,
      PlaneRequest:
        swagger_schema do
          title("PlaneRequest")
          description("POST body for creating a plane")
          property(:plane, Schema.ref(:Plane), "The plane details")
        end,
      PlaneResponse:
        swagger_schema do
          title("PlaneResponse")
          description("Response schema for single plane")
          property(:data, Schema.ref(:Plane), "The plane details")
        end,
      PlanesResponse:
        swagger_schema do
          title("PlanesResponse")
          description("Response schema for multiple planes")
          property(:data, Schema.array(:Plane), "The planes details")
        end
    }
  end

  swagger_path(:index) do
    summary("List planes")
    description("Lists existing planes")

    response(200, "OK", Schema.ref(:PlanesResponse))
  end

  swagger_path(:create) do
    summary("Create plane")
    description("Creates a new plane")

    parameter(:plane, :body, Schema.ref(:PlaneRequest), "The plane details")
    response(201, "Created", Schema.ref(:PlaneResponse))
  end

  swagger_path(:show) do
    summary("Show plane")
    description("Show a plane by ID")

    parameter(:id, :path, :string, "Plane ID",
      required: true,
      example: "f3cd3f9b-9019-471b-b2e9-02c475fe2bbd"
    )

    response(200, "OK", Schema.ref(:PlaneResponse))
  end

  swagger_path(:update) do
    summary("Update plane")
    description("Update all attributes of a plane")

    parameter(:id, :path, :string, "Plane ID",
      required: true,
      example: "f3cd3f9b-9019-471b-b2e9-02c475fe2bbd"
    )

    parameter(:plane, :body, Schema.ref(:PlaneRequest), "The plane details")
    response(200, "Updated", Schema.ref(:PlaneResponse))
  end

  swagger_path(:delete) do
    summary("Delete plane")
    description("Delete a plane by ID")

    parameter(:id, :path, :integer, "Plane ID", required: true, example: 3)
    response(204, "No Content - Deleted Successfully")
  end
end
