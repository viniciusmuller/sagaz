defmodule FlightService.FlightsTest do
  use FlightService.DataCase

  alias FlightService.Flights

  describe "planes" do
    alias FlightService.Flights.Plane

    import FlightService.FlightsFixtures

    @invalid_attrs %{capacity: nil, name: nil}

    test "list_planes/0 returns all planes" do
      plane = plane_fixture()
      assert Flights.list_planes() == [plane]
    end

    test "get_plane!/1 returns the plane with given id" do
      plane = plane_fixture()
      assert Flights.get_plane!(plane.id) == plane
    end

    test "create_plane/1 with valid data creates a plane" do
      valid_attrs = %{capacity: 42, name: "some name"}

      assert {:ok, %Plane{} = plane} = Flights.create_plane(valid_attrs)
      assert plane.capacity == 42
      assert plane.name == "some name"
    end

    test "create_plane/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_plane(@invalid_attrs)
    end

    test "update_plane/2 with valid data updates the plane" do
      plane = plane_fixture()
      update_attrs = %{capacity: 43, name: "some updated name"}

      assert {:ok, %Plane{} = plane} = Flights.update_plane(plane, update_attrs)
      assert plane.capacity == 43
      assert plane.name == "some updated name"
    end

    test "update_plane/2 with invalid data returns error changeset" do
      plane = plane_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_plane(plane, @invalid_attrs)
      assert plane == Flights.get_plane!(plane.id)
    end

    test "delete_plane/1 deletes the plane" do
      plane = plane_fixture()
      assert {:ok, %Plane{}} = Flights.delete_plane(plane)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_plane!(plane.id) end
    end

    test "change_plane/1 returns a plane changeset" do
      plane = plane_fixture()
      assert %Ecto.Changeset{} = Flights.change_plane(plane)
    end
  end

  describe "flights" do
    alias FlightService.Flights.Flight

    import FlightService.FlightsFixtures

    @invalid_attrs %{depart_time: nil, from: nil, to: nil}

    test "list_flights/0 returns all flights" do
      flight = flight_fixture()
      assert Flights.list_flights() == [flight]
    end

    test "get_flight!/1 returns the flight with given id" do
      flight = flight_fixture()
      assert Flights.get_flight!(flight.id) == flight
    end

    test "create_flight/1 with valid data creates a flight" do
      valid_attrs = %{
        plane_id: "0cc1add8-7dfc-4ea9-9862-0cf4f8a95191",
        depart_time: ~U[2023-04-03 22:24:41Z],
        arrival_time: ~U[2023-04-04 22:24:41Z],
        from: "ABC",
        to: "ABD"
      }

      assert {:ok, %Flight{} = flight} = Flights.create_flight(valid_attrs)
      assert flight.depart_time == ~U[2023-04-03 22:24:41Z]
      assert flight.arrival_time == ~U[2023-04-04 22:24:41Z]
      assert flight.from == "ABC"
      assert flight.to == "ABD"
    end

    test "create_flight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flights.create_flight(@invalid_attrs)
    end

    test "update_flight/2 with valid data updates the flight" do
      flight = flight_fixture()
      update_attrs = %{depart_time: ~U[2023-04-03 22:24:41Z], from: "BCD", to: "BCE"}

      assert {:ok, %Flight{} = flight} = Flights.update_flight(flight, update_attrs)
      assert flight.depart_time == ~U[2023-04-03 22:24:41Z]
      assert flight.from == "BCD"
      assert flight.to == "BCE"
    end

    test "update_flight/2 with invalid data returns error changeset" do
      flight = flight_fixture()
      assert {:error, %Ecto.Changeset{}} = Flights.update_flight(flight, @invalid_attrs)
      assert flight == Flights.get_flight!(flight.id)
    end

    test "delete_flight/1 deletes the flight" do
      flight = flight_fixture()
      assert {:ok, %Flight{}} = Flights.delete_flight(flight)
      assert_raise Ecto.NoResultsError, fn -> Flights.get_flight!(flight.id) end
    end

    test "change_flight/1 returns a flight changeset" do
      flight = flight_fixture()
      assert %Ecto.Changeset{} = Flights.change_flight(flight)
    end
  end
end
