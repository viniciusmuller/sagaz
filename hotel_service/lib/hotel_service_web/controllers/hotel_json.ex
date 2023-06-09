defmodule HotelServiceWeb.HotelJSON do
  alias HotelService.Hotels.Hotel

  @doc """
  Renders a list of hotels.
  """
  def index(%{hotels: hotels}) do
    %{data: for(hotel <- hotels, do: data(hotel))}
  end

  @doc """
  Renders a single hotel.
  """
  def show(%{hotel: hotel}) do
    %{data: data(hotel)}
  end

  defp data(%Hotel{} = hotel) do
    %{
      id: hotel.id,
      name: hotel.name,
      country_iso: hotel.country_iso,
      stars: hotel.stars,
      capacity: hotel.capacity,
      inserted_at: hotel.inserted_at,
      updated_at: hotel.updated_at
    }
  end
end
