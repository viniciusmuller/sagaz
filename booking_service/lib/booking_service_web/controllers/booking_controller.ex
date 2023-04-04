defmodule BookingServiceWeb.BookingController do
  use BookingServiceWeb, :controller

  alias BookingService.Bookings
  alias BookingService.Bookings.{Booking, BookTravelSchema}

  action_fallback BookingServiceWeb.FallbackController

  def index(conn, _params) do
    bookings = Bookings.list_bookings()
    render(conn, :index, bookings: bookings)
  end

  def create(conn, %{"booking" => booking_params}) do
    changeset = BookTravelSchema.changeset(booking_params)

    if changeset.valid? do
      with {:ok, booking, _effects} <- BookingService.Sagas.book_travel(changeset.changes) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/bookings/#{booking}")
        |> render(:show, booking: booking)
      end
    else
      {:error, changeset}
    end
  end

  def show(conn, %{"id" => id}) do
    booking = Bookings.get_booking!(id)
    render(conn, :show, booking: booking)
  end

  def update(conn, %{"id" => id, "booking" => booking_params}) do
    booking = Bookings.get_booking!(id)

    with {:ok, %Booking{} = booking} <- Bookings.update_booking(booking, booking_params) do
      render(conn, :show, booking: booking)
    end
  end

  def delete(conn, %{"id" => id}) do
    booking = Bookings.get_booking!(id)

    with {:ok, %Booking{}} <- Bookings.delete_booking(booking) do
      send_resp(conn, :no_content, "")
    end
  end
end
