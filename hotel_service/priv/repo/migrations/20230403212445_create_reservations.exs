defmodule HotelService.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :days, :integer
      add :hotel, references(:hotels, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:reservations, [:hotel])
  end
end
