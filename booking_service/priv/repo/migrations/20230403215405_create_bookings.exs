defmodule BookingService.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :flight_id, :uuid
      add :reservation_id, :uuid

      timestamps()
    end
  end
end
