defmodule BookingService.BookingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BookingService.Bookings` context.
  """

  @doc """
  Generate a booking.
  """
  def booking_fixture(attrs \\ %{}) do
    {:ok, booking} =
      attrs
      |> Enum.into(%{
        flight_id: "7488a646-e31f-11e4-aace-600308960662",
        reservation_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> BookingService.Bookings.create_booking()

    booking
  end
end
