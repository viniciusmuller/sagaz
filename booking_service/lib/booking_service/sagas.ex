defmodule BookingService.Sagas do
  import Sage
  require Logger

  alias BookingService.APIs.{FlightsService, HotelsService}
  alias BookingService.Bookings

  @spec book_travel(attrs :: map()) ::
          {:ok, last_effect :: any(), all_effects :: map()} | {:error, reason :: any()}
  def book_travel(attrs) do
    new()
    |> run(:flight, &book_flight/2, &unbook_flight/3)
    |> run(:reservation, &create_reservation/2, &cancel_reservation/3)
    |> run(:booking, &create_booking/2)
    |> execute(attrs)
  end

  defp create_reservation(_effects_so_far, %{hotel_id: hotel_id, days: days} = attrs) do
    Logger.info("Creating reservation")
    {:ok, reservation} = HotelsService.create_reservation(attrs)
  end

  defp cancel_reservation(%{id: reservation_id}, _, _attrs) do
    Logger.info("Cancelling reservation: #{reservation_id}")
    :ok = HotelsService.cancel_reservation(reservation_id)
  end

  defp cancel_reservation(nil, _, _attrs) do
    Logger.info("Reservation failed")
  end

  defp book_flight(_effects_so_far, %{hotel_id: hotel_id, days: days} = attrs) do
    Logger.info("Booking flight")
    {:ok, flight} = FlightsService.book_flight(attrs)
  end

  defp unbook_flight(%{id: flight_id}, _, _attrs) do
    Logger.info("Unbooking flight: #{flight_id}")
    :ok = FlightsService.unbook_flight(flight_id)
  end

  defp unbook_flight(nil, _, _attrs) do
    Logger.info("Flight booking failed")
  end

  defp create_booking(%{reservation: r, flight: f}, _attrs) do
    {:ok, booking} = Bookings.create_booking(%{flight_id: f.id, reservation_id: r.id})
    Logger.info("Booking #{booking.id} created!")
    {:ok, booking}
  end
end
