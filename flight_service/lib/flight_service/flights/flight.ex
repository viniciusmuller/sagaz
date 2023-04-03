defmodule FlightService.Flights.Flight do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "flights" do
    field :depart_time, :date
    field :from, :string
    field :to, :string
    field :plane, :binary_id

    timestamps()
  end

  @doc false
  def changeset(flight, attrs) do
    flight
    |> cast(attrs, [:from, :to, :depart_time])
    |> validate_required([:from, :to, :depart_time])
    |> validate_length(:from, is: 3) # IATA Code
    |> validate_length(:to, is: 3) # IATA Code
  end
end
