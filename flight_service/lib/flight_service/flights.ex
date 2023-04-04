defmodule FlightService.Flights do
  @moduledoc """
  The Flights context.
  """

  import Ecto.Query, warn: false
  alias FlightService.Repo

  alias FlightService.Flights.Plane

  @doc """
  Returns the list of planes.

  ## Examples

      iex> list_planes()
      [%Plane{}, ...]

  """
  def list_planes do
    Repo.all(Plane)
  end

  @doc """
  Gets a single plane.

  Raises `Ecto.NoResultsError` if the Plane does not exist.

  ## Examples

      iex> get_plane!(123)
      %Plane{}

      iex> get_plane!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plane!(id), do: Repo.get!(Plane, id)

  @doc """
  Creates a plane.

  ## Examples

      iex> create_plane(%{field: value})
      {:ok, %Plane{}}

      iex> create_plane(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plane(attrs \\ %{}) do
    %Plane{}
    |> Plane.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plane.

  ## Examples

      iex> update_plane(plane, %{field: new_value})
      {:ok, %Plane{}}

      iex> update_plane(plane, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plane(%Plane{} = plane, attrs) do
    plane
    |> Plane.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plane.

  ## Examples

      iex> delete_plane(plane)
      {:ok, %Plane{}}

      iex> delete_plane(plane)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plane(%Plane{} = plane) do
    Repo.delete(plane)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plane changes.

  ## Examples

      iex> change_plane(plane)
      %Ecto.Changeset{data: %Plane{}}

  """
  def change_plane(%Plane{} = plane, attrs \\ %{}) do
    Plane.changeset(plane, attrs)
  end

  alias FlightService.Flights.Flight

  @doc """
  Returns the list of flights.

  ## Examples

      iex> list_flights()
      [%Flight{}, ...]

  """
  def list_flights do
    Repo.all(Flight)
  end

  @doc """
  Gets a single flight.

  Raises `Ecto.NoResultsError` if the Flight does not exist.

  ## Examples

      iex> get_flight!(123)
      %Flight{}

      iex> get_flight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flight!(id), do: Repo.get!(Flight, id)

  @doc """
  Creates a flight.

  ## Examples

      iex> create_flight(%{field: value})
      {:ok, %Flight{}}

      iex> create_flight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flight(attrs \\ %{}) do
    %Flight{}
    |> Flight.changeset(attrs)
    |> Repo.insert()
  end

  def book_flight(attrs) do
    with :ok <- book_flight_api(attrs) do
      create_flight(attrs)
    end
  end

  defp book_flight_api(_attrs) do
    30..50
    |> Enum.random()
    |> :timer.sleep()

    :ok
  end

  @doc """
  Updates a flight.

  ## Examples

      iex> update_flight(flight, %{field: new_value})
      {:ok, %Flight{}}

      iex> update_flight(flight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flight(%Flight{} = flight, attrs) do
    flight
    |> Flight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a flight.

  ## Examples

      iex> delete_flight(flight)
      {:ok, %Flight{}}

      iex> delete_flight(flight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flight(%Flight{} = flight) do
    Repo.delete(flight)
  end

  def unbook_flight(%Flight{} = flight) do
    with :ok <- unbook_flight_api(flight) do
      Repo.delete(flight)
    end
  end

  defp unbook_flight_api(_attrs) do
    30..50
    |> Enum.random()
    |> :timer.sleep()

    :ok
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flight changes.

  ## Examples

      iex> change_flight(flight)
      %Ecto.Changeset{data: %Flight{}}

  """
  def change_flight(%Flight{} = flight, attrs \\ %{}) do
    Flight.changeset(flight, attrs)
  end
end
