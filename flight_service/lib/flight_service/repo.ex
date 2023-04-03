defmodule FlightService.Repo do
  use Ecto.Repo,
    otp_app: :flight_service,
    adapter: Ecto.Adapters.Postgres
end
