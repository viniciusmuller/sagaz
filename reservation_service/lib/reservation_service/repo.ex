defmodule ReservationService.Repo do
  use Ecto.Repo,
    otp_app: :reservation_service,
    adapter: Ecto.Adapters.Postgres
end
