defmodule BookingServiceWeb.BookingController do
  use BookingServiceWeb, :controller
  use OpenApiSpex.ControllerSpecs
  alias OpenApiSpex.Schema

  alias BookingService.Bookings
  alias BookingService.Bookings.{Booking, BookTravelSchema}
  alias BookingServiceWeb.ApiSchemas

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

  # TODO: Create new saga and cancel reservation/flight when removing booking
  def delete(conn, %{"id" => id}) do
    booking = Bookings.get_booking!(id)

    with {:ok, %Booking{}} <- Bookings.delete_booking(booking) do
      send_resp(conn, :no_content, "")
    end
  end

  operation(:index,
    summary: "List bookings",
    responses: [
      ok: {"Blane", "application/json", %Schema{type: :array, items: ApiSchemas.BookingResponse}}
    ]
  )

  operation(:create,
    summary: "Book travel",
    request_body:
      {"Necessary booking data", "application/json", ApiSchemas.CreateBooking, required: true},
    responses: [
      created: {"Booking", "application/json", ApiSchemas.BookingResponse}
    ]
  )

  operation(:show,
    summary: "Show booking",
    parameters: [
      id: [
        in: :path,
        type: :string,
        description: "Booking ID",
        required: true
      ]
    ],
    responses: [
      ok: {"Booking", "application/json", ApiSchemas.BookingResponse}
    ]
  )

  operation(:update,
    summary: "Update a booking",
    parameters: [
      id: [in: :path, description: "Booking ID", type: :string]
    ],
    request_body: {"Booking params", "application/json", ApiSchemas.UpdateBooking, required: true},
    responses: [
      ok: {"Booking response", "application/json", ApiSchemas.BookingResponse}
    ]
  )

  operation(:delete,
    summary: "Unbooks a travel",
    parameters: [
      id: [in: :path, description: "Booking ID", type: :string]
    ],
    responses: [
      no_content: "Succesfully unbooked"
    ]
  )
end
