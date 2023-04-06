defmodule FlightServiceWeb.PlaneController do
  use FlightServiceWeb, :controller
  use OpenApiSpex.ControllerSpecs
  alias OpenApiSpex.Schema

  alias FlightService.Flights
  alias FlightService.Flights.Plane
  alias FlightServiceWeb.ApiSchemas

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

  tags(["Planes"])

  operation(:index,
    summary: "List planes",
    responses: [
      ok: {"Plane", "application/json", %Schema{type: :array, items: ApiSchemas.PlaneResponse}}
    ]
  )

  operation(:create,
    summary: "Create plane",
    request_body:
      {"The plane attributes", "application/json", ApiSchemas.PlaneRequest, required: true},
    responses: [
      created: {"Plane", "application/json", ApiSchemas.PlaneResponse}
    ]
  )

  operation(:show,
    summary: "Show plane",
    parameters: [
      id: [
        in: :path,
        type: :string,
        description: "Plane ID",
        required: true
      ]
    ],
    responses: [
      ok: {"Plane", "application/json", ApiSchemas.PlaneResponse}
    ]
  )

  operation(:update,
    summary: "Update a plane",
    parameters: [
      id: [in: :path, description: "Plane ID", type: :string]
    ],
    request_body: {"Plane params", "application/json", ApiSchemas.PlaneRequest, required: true},
    responses: [
      ok: {"Plane response", "application/json", ApiSchemas.PlaneResponse}
    ]
  )

  operation(:delete,
    summary: "Deletes a plane",
    parameters: [
      id: [in: :path, description: "Plane ID", type: :string]
    ],
    responses: [
      no_content: "Succesfully deleted"
    ]
  )
end
