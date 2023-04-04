defmodule HotelServiceWeb.ReservationJSON do
  alias HotelService.Hotels.Reservation

  @doc """
  Renders a list of reservations.
  """
  def index(%{reservations: reservations}) do
    %{data: for(reservation <- reservations, do: data(reservation))}
  end

  @doc """
  Renders a single reservation.
  """
  def show(%{reservation: reservation}) do
    %{data: data(reservation)}
  end

  defp data(%Reservation{} = reservation) do
    %{
      id: reservation.id,
      hotel_id: reservation.hotel_id,
      days: reservation.days
    }
  end
end
