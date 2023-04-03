defmodule FlightService.Repo.Migrations.CreateFlights do
  use Ecto.Migration

  def change do
    create table(:flights, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :from, :string
      add :to, :string
      add :depart_time, :date
      add :plane, references(:planes, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:flights, [:plane])
  end
end
