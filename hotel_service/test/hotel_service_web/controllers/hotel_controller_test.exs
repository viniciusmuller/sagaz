defmodule HotelServiceWeb.HotelControllerTest do
  use HotelServiceWeb.ConnCase

  import HotelService.HotelsFixtures

  alias HotelService.Hotels.Hotel

  @create_attrs %{
    capacity: 42,
    country_iso: "BR",
    name: "some name",
    stars: 42
  }
  @update_attrs %{
    capacity: 43,
    country_iso: "US",
    name: "some updated name",
    stars: 43
  }
  @invalid_attrs %{capacity: nil, name: nil, stars: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all hotels", %{conn: conn} do
      conn = get(conn, ~p"/api/hotels")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create hotel" do
    test "renders hotel when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/hotels", hotel: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/hotels/#{id}")

      assert %{
               "id" => ^id,
               "capacity" => 42,
               "name" => "some name",
               "stars" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/hotels", hotel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update hotel" do
    setup [:create_hotel]

    test "renders hotel when data is valid", %{conn: conn, hotel: %Hotel{id: id} = hotel} do
      conn = put(conn, ~p"/api/hotels/#{hotel}", hotel: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/hotels/#{id}")

      assert %{
               "id" => ^id,
               "capacity" => 43,
               "name" => "some updated name",
               "stars" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, hotel: hotel} do
      conn = put(conn, ~p"/api/hotels/#{hotel}", hotel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete hotel" do
    setup [:create_hotel]

    test "deletes chosen hotel", %{conn: conn, hotel: hotel} do
      conn = delete(conn, ~p"/api/hotels/#{hotel}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/hotels/#{hotel}")
      end
    end
  end

  defp create_hotel(_) do
    hotel = hotel_fixture()
    %{hotel: hotel}
  end
end
