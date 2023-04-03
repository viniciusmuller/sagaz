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
      depart_time: flight.depart_time
    }
  end
end
