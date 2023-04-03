defmodule FlightService.Repo.Migrations.FixDepartTimeAndAddArrivalTime do
  use Ecto.Migration

  def change do
    alter table(:flights) do
      modify :depart_time, :utc_datetime
      add :arrival_time, :utc_datetime
    end
  end
end
