defmodule FlightServiceWeb.PlaneJSON do
  alias FlightService.Flights.Plane

  @doc """
  Renders a list of planes.
  """
  def index(%{planes: planes}) do
    %{data: for(plane <- planes, do: data(plane))}
  end

  @doc """
  Renders a single plane.
  """
  def show(%{plane: plane}) do
    %{data: data(plane)}
  end

  defp data(%Plane{} = plane) do
    %{
      id: plane.id,
      name: plane.name,
      capacity: plane.capacity
    }
  end
end
