defmodule HotelServiceWeb.ReservationController do
  use HotelServiceWeb, :controller
  use OpenApiSpex.ControllerSpecs
  alias OpenApiSpex.Schema

  alias HotelService.Hotels
  alias HotelService.Hotels.{Hotel, Reservation}
  alias HotelServiceWeb.ApiSchemas

  action_fallback HotelServiceWeb.FallbackController

  def index(conn, _params) do
    reservations = Hotels.list_reservations()
    render(conn, :index, reservations: reservations)
  end

  def create(conn, %{"reservation" => reservation_params}) do
    with {:ok, %Hotel{}} <- Hotels.fetch_hotel(reservation_params["hotel_id"]),
         {:ok, %Reservation{} = reservation} <- Hotels.reserve_hotel(reservation_params) do
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

    with {:ok, %Reservation{} = reservation} <-
           Hotels.update_reservation(reservation, reservation_params) do
      render(conn, :show, reservation: reservation)
    end
  end

  def delete(conn, %{"id" => id}) do
    reservation = Hotels.get_reservation!(id)

    with {:ok, %Reservation{}} <- Hotels.cancel_reservation(reservation) do
      send_resp(conn, :no_content, "")
    end
  end

  tags(["Reservations"])

  operation(:index,
    summary: "List reservations",
    responses: [
      ok:
        {"Reservations", "application/json",
         %Schema{type: :array, items: ApiSchemas.ReservationResponse}}
    ]
  )

  operation(:create,
    summary: "Create reservation",
    request_body:
      {"Reservation attributes", "application/json", ApiSchemas.ReservationRequest,
       required: true},
    responses: [
      created: {"Reservation", "application/json", ApiSchemas.ReservationResponse}
    ]
  )

  operation(:show,
    summary: "Show reservation",
    parameters: [
      id: [
        in: :path,
        type: :string,
        description: "Reservation ID",
        required: true
      ]
    ],
    responses: [
      ok: {"Reservation", "application/json", ApiSchemas.ReservationResponse}
    ]
  )

  operation(:update,
    summary: "Update reservation",
    parameters: [
      id: [in: :path, description: "Reservation ID", type: :string]
    ],
    request_body:
      {"Reservation params", "application/json", ApiSchemas.ReservationRequest, required: true},
    responses: [
      ok: {"Reservation", "application/json", ApiSchemas.ReservationResponse}
    ]
  )

  operation(:delete,
    summary: "Delete reservation",
    parameters: [
      id: [in: :path, description: "Reservation ID", type: :string]
    ],
    responses: [
      no_content: "Succesfully deleted"
    ]
  )
end
