defmodule HotelService.HotelsTest do
  use HotelService.DataCase

  alias HotelService.Hotels

  describe "hotels" do
    alias HotelService.Hotels.Hotel

    import HotelService.HotelsFixtures

    @invalid_attrs %{capacity: nil, name: nil, stars: nil}

    test "list_hotels/0 returns all hotels" do
      hotel = hotel_fixture()
      assert Hotels.list_hotels() == [hotel]
    end

    test "get_hotel!/1 returns the hotel with given id" do
      hotel = hotel_fixture()
      assert Hotels.get_hotel!(hotel.id) == hotel
    end

    test "create_hotel/1 with valid data creates a hotel" do
      valid_attrs = %{capacity: 42, name: "some name", stars: 42, country_iso: "BR"}

      assert {:ok, %Hotel{} = hotel} = Hotels.create_hotel(valid_attrs)
      assert hotel.capacity == 42
      assert hotel.name == "some name"
      assert hotel.stars == 42
    end

    test "create_hotel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hotels.create_hotel(@invalid_attrs)
    end

    test "update_hotel/2 with valid data updates the hotel" do
      hotel = hotel_fixture()
      update_attrs = %{capacity: 43, name: "some updated name", stars: 43}

      assert {:ok, %Hotel{} = hotel} = Hotels.update_hotel(hotel, update_attrs)
      assert hotel.capacity == 43
      assert hotel.name == "some updated name"
      assert hotel.stars == 43
    end

    test "update_hotel/2 with invalid data returns error changeset" do
      hotel = hotel_fixture()
      assert {:error, %Ecto.Changeset{}} = Hotels.update_hotel(hotel, @invalid_attrs)
      assert hotel == Hotels.get_hotel!(hotel.id)
    end

    test "delete_hotel/1 deletes the hotel" do
      hotel = hotel_fixture()
      assert {:ok, %Hotel{}} = Hotels.delete_hotel(hotel)
      assert_raise Ecto.NoResultsError, fn -> Hotels.get_hotel!(hotel.id) end
    end

    test "change_hotel/1 returns a hotel changeset" do
      hotel = hotel_fixture()
      assert %Ecto.Changeset{} = Hotels.change_hotel(hotel)
    end
  end

  describe "reservations" do
    alias HotelService.Hotels.Reservation

    import HotelService.HotelsFixtures

    @invalid_attrs %{days: nil}

    test "list_reservations/0 returns all reservations" do
      reservation = reservation_fixture()
      assert Hotels.list_reservations() == [reservation]
    end

    test "get_reservation!/1 returns the reservation with given id" do
      reservation = reservation_fixture()
      assert Hotels.get_reservation!(reservation.id) == reservation
    end

    test "create_reservation/1 with valid data creates a reservation" do
      valid_attrs = %{days: 42}

      assert {:ok, %Reservation{} = reservation} = Hotels.create_reservation(valid_attrs)
      assert reservation.days == 42
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hotels.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()
      update_attrs = %{days: 43}

      assert {:ok, %Reservation{} = reservation} = Hotels.update_reservation(reservation, update_attrs)
      assert reservation.days == 43
    end

    test "update_reservation/2 with invalid data returns error changeset" do
      reservation = reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Hotels.update_reservation(reservation, @invalid_attrs)
      assert reservation == Hotels.get_reservation!(reservation.id)
    end

    test "delete_reservation/1 deletes the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{}} = Hotels.delete_reservation(reservation)
      assert_raise Ecto.NoResultsError, fn -> Hotels.get_reservation!(reservation.id) end
    end

    test "change_reservation/1 returns a reservation changeset" do
      reservation = reservation_fixture()
      assert %Ecto.Changeset{} = Hotels.change_reservation(reservation)
    end
  end
end
