defmodule HotelServiceWeb.ReservationController do
  use HotelServiceWeb, :controller

  alias HotelService.Hotels
  alias HotelService.Hotels.Reservation

  action_fallback HotelServiceWeb.FallbackController

  def index(conn, _params) do
    reservations = Hotels.list_reservations()
    render(conn, :index, reservations: reservations)
  end

  def create(conn, %{"reservation" => reservation_params}) do
    with {:ok, %Reservation{} = reservation} <- Hotels.reserve_hotel(reservation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/reservations/#{reservation}")
      |> render(:show, reservation: reservation)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation = Hotels.get_reservation!(id)
    render(conn, :show, reservation: reservation)
  end

  def update(conn, %{"id" => id, "reservation" => reservation_params}) do
    reservation = Hotels.get_reservation!(id)

    with {:ok, %Reservation{} = reservation} <- Hotels.update_reservation(reservation, reservation_params) do
      render(conn, :show, reservation: reservation)
    end
  end

  def delete(conn, %{"id" => id}) do
    reservation = Hotels.get_reservation!(id)

    with {:ok, %Reservation{}} <- Hotels.cancel_reservation(reservation) do
      send_resp(conn, :no_content, "")
    end
  end
end
