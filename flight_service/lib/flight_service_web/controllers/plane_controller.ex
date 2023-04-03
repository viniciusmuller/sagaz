defmodule FlightServiceWeb.PlaneController do
  use FlightServiceWeb, :controller

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
end
