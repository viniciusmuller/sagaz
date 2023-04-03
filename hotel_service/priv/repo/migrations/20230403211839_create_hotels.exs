defmodule HotelService.Repo.Migrations.CreateHotels do
  use Ecto.Migration

  def change do
    create table(:hotels, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :stars, :integer
      add :capacity, :integer

      timestamps()
    end
  end
end
