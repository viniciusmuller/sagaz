defmodule FlightService.Repo.Migrations.CreatePlanes do
  use Ecto.Migration

  def change do
    create table(:planes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :capacity, :integer

      timestamps()
    end
  end
end
