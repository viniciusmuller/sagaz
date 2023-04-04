defmodule HotelService.Hotels.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reservations" do
    field :days, :integer
    belongs_to :hotel, HotelService.Hotels.Hotel

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:days, :hotel_id])
    |> validate_required([:days, :hotel_id])
  end
end
