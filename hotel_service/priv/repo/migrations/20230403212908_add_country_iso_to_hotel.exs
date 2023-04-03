defmodule HotelService.Repo.Migrations.AddCountryIsoToHotel do
  use Ecto.Migration

  def change do
    alter table(:hotels) do
      add :country_iso, :string
    end
  end
end
