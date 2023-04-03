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
      stars: hotel.stars,
      capacity: hotel.capacity
    }
  end
end
