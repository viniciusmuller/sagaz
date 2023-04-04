defmodule HotelService.Hotels do
  @moduledoc """
  The Hotels context.
  """

  import Ecto.Query, warn: false
  alias HotelService.Repo

  alias HotelService.Hotels.Hotel

  @doc """
  Returns the list of hotels.

  ## Examples

      iex> list_hotels()
      [%Hotel{}, ...]

  """
  def list_hotels do
    Repo.all(Hotel)
  end

  @doc """
  Gets a single hotel.

  Raises `Ecto.NoResultsError` if the Hotel does not exist.

  ## Examples

      iex> get_hotel!(123)
      %Hotel{}

      iex> get_hotel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hotel!(id), do: Repo.get!(Hotel, id)

  def fetch_hotel(id) do
    case Repo.get(Hotel, id) do
      nil -> {:error, :not_found}
      hotel -> {:ok, hotel}
    end
  end

  @doc """
  Creates a hotel.

  ## Examples

      iex> create_hotel(%{field: value})
      {:ok, %Hotel{}}

      iex> create_hotel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hotel(attrs \\ %{}) do
    %Hotel{}
    |> Hotel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hotel.

  ## Examples

      iex> update_hotel(hotel, %{field: new_value})
      {:ok, %Hotel{}}

      iex> update_hotel(hotel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hotel(%Hotel{} = hotel, attrs) do
    hotel
    |> Hotel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hotel.

  ## Examples

      iex> delete_hotel(hotel)
      {:ok, %Hotel{}}

      iex> delete_hotel(hotel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hotel(%Hotel{} = hotel) do
    Repo.delete(hotel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hotel changes.

  ## Examples

      iex> change_hotel(hotel)
      %Ecto.Changeset{data: %Hotel{}}

  """
  def change_hotel(%Hotel{} = hotel, attrs \\ %{}) do
    Hotel.changeset(hotel, attrs)
  end

  alias HotelService.Hotels.Reservation

  @doc """
  Returns the list of reservations.

  ## Examples

      iex> list_reservations()
      [%Reservation{}, ...]

  """
  def list_reservations do
    Repo.all(Reservation)
  end

  @doc """
  Gets a single reservation.

  Raises `Ecto.NoResultsError` if the Reservation does not exist.

  ## Examples

      iex> get_reservation!(123)
      %Reservation{}

      iex> get_reservation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reservation!(id), do: Repo.get!(Reservation, id)

  @doc """
  Creates a reservation.

  ## Examples

      iex> create_reservation(%{field: value})
      {:ok, %Reservation{}}

      iex> create_reservation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reservation(attrs \\ %{}) do
    %Reservation{}
    |> Reservation.changeset(attrs)
    |> Repo.insert()
  end

  def reserve_hotel(attrs) do
    # TODO: validate using changeset before sending to API (both for flight and hotel projects)
    with :ok <- reserve_hotel_api(attrs) do
      create_reservation(attrs)
    end
  end

  defp reserve_hotel_api(_attrs) do
    30..50
    |> Enum.random()
    |> :timer.sleep()

    :ok
  end

  @doc """
  Updates a reservation.

  ## Examples

      iex> update_reservation(reservation, %{field: new_value})
      {:ok, %Reservation{}}

      iex> update_reservation(reservation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reservation(%Reservation{} = reservation, attrs) do
    reservation
    |> Reservation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reservation.

  ## Examples

      iex> delete_reservation(reservation)
      {:ok, %Reservation{}}

      iex> delete_reservation(reservation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reservation(%Reservation{} = reservation) do
    Repo.delete(reservation)
  end

  def cancel_reservation(attrs) do
    # TODO: validate using changeset before sending to API (both for flight and hotel projects)
    with :ok <- cancel_reservation_api(attrs) do
      delete_reservation(attrs)
    end
  end

  defp cancel_reservation_api(_attrs) do
    30..50
    |> Enum.random()
    |> :timer.sleep()

    :ok
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reservation changes.

  ## Examples

      iex> change_reservation(reservation)
      %Ecto.Changeset{data: %Reservation{}}

  """
  def change_reservation(%Reservation{} = reservation, attrs \\ %{}) do
    Reservation.changeset(reservation, attrs)
  end
end
