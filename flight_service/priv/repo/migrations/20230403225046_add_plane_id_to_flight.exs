defmodule FlightService.Repo.Migrations.AddPlaneIdToFlight do
  use Ecto.Migration

  def change do
    alter table(:flights) do
      add :plane_id, :binary_id
    end
  end
end
