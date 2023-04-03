defmodule FlightService.Flights.Flight do
  use Ecto.Schema
  import Ecto.Changeset

  alias FlightService.Flights

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "flights" do
    field :depart_time, :utc_datetime
    field :arrival_time, :utc_datetime
    field :from, :string # IATA Code
    field :to, :string # IATA Code
    belongs_to :plane, Flights.Plane

    timestamps()
  end

  @doc false
  def changeset(flight, attrs) do
    flight
    |> cast(attrs, [:from, :to, :depart_time, :arrival_time, :plane_id])
    |> validate_required([:from, :to, :depart_time, :arrival_time, :plane_id])
    |> validate_length(:from, is: 3) # IATA Code
    |> validate_length(:to, is: 3) # IATA Code
  end
end
