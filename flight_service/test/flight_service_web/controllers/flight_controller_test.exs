defmodule FlightServiceWeb.FlightControllerTest do
  use FlightServiceWeb.ConnCase

  import FlightService.FlightsFixtures

  alias FlightService.Flights.Flight

  @create_attrs %{
    plane_id: "0cc1add8-7dfc-4ea9-9862-0cf4f8a95191",
    depart_time: ~U[2023-04-03 22:24:41Z],
    arrival_time: ~U[2023-04-04 22:24:41Z],
    from: "ABC",
    to: "ABD"
  }
  @update_attrs %{
    plane_id: "0cc1add8-7dfc-4ea9-9862-0cf4f8a95191",
    depart_time: ~U[2023-04-04 22:24:41Z],
    arrival_time: ~U[2023-04-05 22:24:41Z],
    from: "BCD",
    to: "BCE"
  }
  @invalid_attrs %{depart_time: nil, from: nil, to: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all flights", %{conn: conn} do
      conn = get(conn, ~p"/api/flights")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create flight" do
    test "renders flight when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/flights", flight: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/flights/#{id}")

      assert %{
               "id" => ^id,
               "depart_time" => "2023-04-03T22:24:41Z",
               "arrival_time" => "2023-04-04T22:24:41Z",
               "from" => "ABC",
               "to" => "ABD"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/flights", flight: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update flight" do
    setup [:create_flight]

    test "renders flight when data is valid", %{conn: conn, flight: %Flight{id: id} = flight} do
      conn = put(conn, ~p"/api/flights/#{flight}", flight: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/flights/#{id}")

      assert %{
               "id" => ^id,
               "depart_time" => "2023-04-04T22:24:41Z",
               "arrival_time" => "2023-04-05T22:24:41Z",
               "from" => "BCD",
               "to" => "BCE"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, flight: flight} do
      conn = put(conn, ~p"/api/flights/#{flight}", flight: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete flight" do
    setup [:create_flight]

    test "deletes chosen flight", %{conn: conn, flight: flight} do
      conn = delete(conn, ~p"/api/flights/#{flight}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/flights/#{flight}")
      end
    end
  end

  defp create_flight(_) do
    flight = flight_fixture()
    %{flight: flight}
  end
end
