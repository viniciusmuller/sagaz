defmodule BookingService.Sagas do
  import Sage

  alias BookingService.APIs.{FlightsService, HotelsService}
  alias BookingService.Bookings

  @spec book_travel(attrs :: map()) ::
          {:ok, last_effect :: any(), all_effects :: map()} | {:error, reason :: any()}
  def book_travel(attrs) do
    new()
    |> run(:flight, &book_flight/2, &unbook_flight/3)
    |> run(:reservation, &create_reservation/2, &cancel_reservation/3)
    |> run(:booking, &create_booking/2)
    |> transaction(BookingService.Repo, attrs)
  end

  # TODO: Add logging
  defp create_reservation(_effects_so_far, %{hotel_id: hotel_id, days: days} = attrs) do
    {:ok, reservation} = HotelsService.create_reservation(attrs)
  end

  defp cancel_reservation(%{reservation: r}, _, _attrs) do
    :ok = HotelsService.cancel_reservation(r.id)
  end

  defp book_flight(_effects_so_far, %{hotel_id: hotel_id, days: days} = attrs) do
    {:ok, flight} = FlightsService.book_flight(attrs)
  end

  defp unbook_flight(%{flight: f}, _, _attrs) do
    :ok = FlightsService.unbook_flight(f.id)
  end

  defp create_booking(%{reservation: r, flight: f}, _attrs) do
    {:ok, booking} = Bookings.create_booking(%{flight_id: f.id, reservation_id: r.id})
  end
end
