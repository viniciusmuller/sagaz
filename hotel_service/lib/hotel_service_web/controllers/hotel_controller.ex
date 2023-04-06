defmodule HotelServiceWeb.HotelController do
  use HotelServiceWeb, :controller
  use OpenApiSpex.ControllerSpecs
  alias OpenApiSpex.Schema

  alias HotelService.Hotels
  alias HotelService.Hotels.Hotel
  alias HotelServiceWeb.ApiSchemas

  action_fallback HotelServiceWeb.FallbackController

  def index(conn, _params) do
    hotels = Hotels.list_hotels()
    render(conn, :index, hotels: hotels)
  end

  def create(conn, %{"hotel" => hotel_params}) do
    with {:ok, %Hotel{} = hotel} <- Hotels.create_hotel(hotel_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/hotels/#{hotel}")
      |> render(:show, hotel: hotel)
    end
  end

  def show(conn, %{"id" => id}) do
    hotel = Hotels.get_hotel!(id)
    render(conn, :show, hotel: hotel)
  end

  def update(conn, %{"id" => id, "hotel" => hotel_params}) do
    hotel = Hotels.get_hotel!(id)

    with {:ok, %Hotel{} = hotel} <- Hotels.update_hotel(hotel, hotel_params) do
      render(conn, :show, hotel: hotel)
    end
  end

  def delete(conn, %{"id" => id}) do
    hotel = Hotels.get_hotel!(id)

    with {:ok, %Hotel{}} <- Hotels.delete_hotel(hotel) do
      send_resp(conn, :no_content, "")
    end
  end

  tags(["Hotels"])

  operation(:index,
    summary: "List hotels",
    responses: [
      ok: {"Hotels", "application/json", %Schema{type: :array, items: ApiSchemas.HotelResponse}}
    ]
  )

  operation(:create,
    summary: "Create hotel",
    request_body:
      {"The hotel attributes", "application/json", ApiSchemas.HotelRequest, required: true},
    responses: [
      created: {"Hotel", "application/json", ApiSchemas.HotelResponse}
    ]
  )

  operation(:show,
    summary: "Show hotel",
    parameters: [
      id: [
        in: :path,
        type: :string,
        description: "Hotel ID",
        required: true
      ]
    ],
    responses: [
      ok: {"Hotel", "application/json", ApiSchemas.HotelResponse}
    ]
  )

  operation(:update,
    summary: "Update hotel",
    parameters: [
      id: [in: :path, description: "Hotel ID", type: :string]
    ],
    request_body: {"Hotel params", "application/json", ApiSchemas.HotelRequest, required: true},
    responses: [
      ok: {"Hotel response", "application/json", ApiSchemas.HotelResponse}
    ]
  )

  operation(:delete,
    summary: "Delete Hotel",
    parameters: [
      id: [in: :path, description: "Hotel ID", type: :string]
    ],
    responses: [
      no_content: "Succesfully deleted"
    ]
  )
end
