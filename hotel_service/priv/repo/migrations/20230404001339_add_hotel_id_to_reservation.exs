defmodule HotelService.Repo.Migrations.AddHotelIdToReservation do
  use Ecto.Migration

  def change do
    alter table(:reservations) do
      add :hotel_id, :binary_id
    end
  end
end
