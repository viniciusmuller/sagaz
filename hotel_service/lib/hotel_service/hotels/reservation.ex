defmodule HotelService.Hotels.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reservations" do
    field :days, :integer
    field :hotel, :binary_id

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:days])
    |> validate_required([:days])
  end
end
