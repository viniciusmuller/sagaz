defmodule HotelService.Setup do
  alias HotelService.Hotels.Hotel

  def seed do
    Ecto.Migrator.with_repo(HotelService.Repo, fn _ ->
      do_seed()
    end)
  end

  defp do_seed do
    unless HotelService.Repo.get_by(Hotel, name: "Brazilian Hotel") do
      HotelService.Repo.insert!(%Hotel{
        name: "Brazilian Hotel",
        country_iso: "BR",
        stars: 4,
        capacity: 50
      })
    end

    unless HotelService.Repo.get_by(Hotel, name: "New York Hotel") do
      HotelService.Repo.insert!(%Hotel{
        name: "New York Hotel",
        country_iso: "US",
        stars: 5,
        capacity: 100
      })
    end

    unless HotelService.Repo.get_by(Hotel, name: "Tokio Hotel") do
      HotelService.Repo.insert!(%Hotel{
        name: "Tokio Hotel",
        country_iso: "JP",
        stars: 4,
        capacity: 75
      })
    end
  end
end
