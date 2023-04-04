defmodule BookingService.Bookings.BookTravelSchema do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :hotel_id, :binary_id
    field :days, :integer
    field :depart_time, :utc_datetime
    field :arrival_time, :utc_datetime
    # IATA code
    field :from, :string
    # IATA code
    field :to, :string
    field :plane_id, :binary_id
  end

  def changeset(attrs \\ %{}) do
    %__MODULE__{}
    |> cast(attrs, [:hotel_id, :days, :arrival_time, :depart_time, :from, :to, :plane_id])
    |> validate_required([:hotel_id, :days, :arrival_time, :depart_time, :from, :to, :plane_id])
  end
end
