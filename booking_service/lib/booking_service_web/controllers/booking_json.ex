defmodule BookingServiceWeb.BookingJSON do
  alias BookingService.Bookings.Booking

  @doc """
  Renders a list of bookings.
  """
  def index(%{bookings: bookings}) do
    %{data: for(booking <- bookings, do: data(booking))}
  end

  @doc """
  Renders a single booking.
  """
  def show(%{booking: booking}) do
    %{data: data(booking)}
  end

  defp data(%Booking{} = booking) do
    %{
      id: booking.id,
      flight_id: booking.flight_id,
      reservation_id: booking.reservation_id
    }
  end
end
