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
        depart_time: ~D[2023-04-02],
        from: "some from",
        to: "some to"
      })
      |> FlightService.Flights.create_flight()

    flight
  end
end
