defmodule BookingService.Bookings.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bookings" do
    field :flight_id, Ecto.UUID
    field :reservation_id, Ecto.UUID

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:flight_id, :reservation_id])
    |> validate_required([:flight_id, :reservation_id])
  end
end
