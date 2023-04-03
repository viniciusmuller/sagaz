defmodule FlightService.Flights.Plane do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "planes" do
    field :capacity, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(plane, attrs) do
    plane
    |> cast(attrs, [:name, :capacity])
    |> validate_required([:name, :capacity])
  end
end
