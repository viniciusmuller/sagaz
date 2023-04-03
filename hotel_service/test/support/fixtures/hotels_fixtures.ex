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
        stars: 42
      })
      |> HotelService.Hotels.create_hotel()

    hotel
  end
end
