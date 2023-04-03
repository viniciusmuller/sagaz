defmodule HotelService.Hotels.Hotel do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "hotels" do
    field :capacity, :integer
    field :country_iso, :string
    field :name, :string
    field :stars, :integer

    timestamps()
  end

  @doc false
  def changeset(hotel, attrs) do
    hotel
    |> cast(attrs, [:name, :stars, :capacity, :country_iso])
    |> validate_required([:name, :stars, :capacity, :country_iso])
    |> validate_length(:country_iso, is: 2)
  end
end
