defmodule FlightServiceWeb.PlaneControllerTest do
  use FlightServiceWeb.ConnCase

  import FlightService.FlightsFixtures

  alias FlightService.Flights.Plane

  @create_attrs %{
    capacity: 42,
    name: "some name"
  }
  @update_attrs %{
    capacity: 43,
    name: "some updated name"
  }
  @invalid_attrs %{capacity: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all planes", %{conn: conn} do
      conn = get(conn, ~p"/api/planes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create plane" do
    test "renders plane when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/planes", plane: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/planes/#{id}")

      assert %{
               "id" => ^id,
               "capacity" => 42,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/planes", plane: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update plane" do
    setup [:create_plane]

    test "renders plane when data is valid", %{conn: conn, plane: %Plane{id: id} = plane} do
      conn = put(conn, ~p"/api/planes/#{plane}", plane: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/planes/#{id}")

      assert %{
               "id" => ^id,
               "capacity" => 43,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, plane: plane} do
      conn = put(conn, ~p"/api/planes/#{plane}", plane: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete plane" do
    setup [:create_plane]

    test "deletes chosen plane", %{conn: conn, plane: plane} do
      conn = delete(conn, ~p"/api/planes/#{plane}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/planes/#{plane}")
      end
    end
  end

  defp create_plane(_) do
    plane = plane_fixture()
    %{plane: plane}
  end
end
