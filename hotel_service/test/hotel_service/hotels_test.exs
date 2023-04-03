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
      valid_attrs = %{capacity: 42, name: "some name", stars: 42}

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
end
