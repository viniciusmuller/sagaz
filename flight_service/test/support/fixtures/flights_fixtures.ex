defmodule FlightService.FlightsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FlightService.Flights` context.
  """

  @doc """
  Generate a plane.
  """
  def plane_fixture(attrs \\ %{}) do
    {:ok, plane} =
      attrs
      |> Enum.into(%{
        capacity: 42,
        name: "some name"
      })
      |> FlightService.Flights.create_plane()

    plane
  end

  @doc """
  Generate a flight.
  """
  def flight_fixture(attrs \\ %{}) do
    {:ok, flight} =
      attrs
      |> Enum.into(%{
        depart_time: ~U[2023-04-03 22:24:41Z],
        arrival_time: ~U[2023-04-04 22:24:41Z],
        from: "AZZ",
        to: "NYA"
      })
      |> FlightService.Flights.create_flight()

    flight
  end
end
