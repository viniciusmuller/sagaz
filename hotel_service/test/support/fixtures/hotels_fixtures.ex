defmodule HotelService.HotelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HotelService.Hotels` context.
  """

  @doc """
  Generate a hotel.
  """
  def hotel_fixture(attrs \\ %{}) do
    {:ok, hotel} =
      attrs
      |> Enum.into(%{
        capacity: 42,
        name: "some name",
        country_iso: "BR",
        stars: 42
      })
      |> HotelService.Hotels.create_hotel()

    hotel
  end

  @doc """
  Generate a reservation.
  """
  def reservation_fixture(attrs \\ %{}) do
    {:ok, reservation} =
      attrs
      |> Enum.into(%{
        days: 42
      })
      |> HotelService.Hotels.create_reservation()

    reservation
  end
end
