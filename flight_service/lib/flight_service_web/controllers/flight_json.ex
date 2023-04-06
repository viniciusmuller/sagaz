defmodule FlightServiceWeb.FlightJSON do
  alias FlightService.Flights.Flight

  @doc """
  Renders a list of flights.
  """
  def index(%{flights: flights}) do
    %{data: for(flight <- flights, do: data(flight))}
  end

  @doc """
  Renders a single flight.
  """
  def show(%{flight: flight}) do
    %{data: data(flight)}
  end

  defp data(%Flight{} = flight) do
    %{
      id: flight.id,
      from: flight.from,
      to: flight.to,
      depart_time: flight.depart_time,
      arrival_time: flight.arrival_time,
      plane_id: flight.plane_id,
      inserted_at: flight.inserted_at,
      updated_at: flight.updated_at
    }
  end
end
