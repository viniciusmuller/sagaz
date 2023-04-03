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

defmodule CreateBookingSchema do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :hotel_id, :binary_id
    field :days, :integer
    field :depart_time, :datetime
    field :arrival_time, :datetime
    # IATA code
    field :from, :string
    # IATA code
    field :to, :string
    field :plane_id, :binary_id
  end

  def changeset(attrs \\ %{}) do
    %CreateBookingSchema{}
    |> cast(attrs, [:hotel_id, :days, :depart_time, :from, :to, :plane_id])
    |> validate_required([:hotel_id, :days, :depart_time, :from, :to, :plane_id])
  end
end
