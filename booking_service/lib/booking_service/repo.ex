defmodule BookingService.Repo do
  use Ecto.Repo,
    otp_app: :booking_service,
    adapter: Ecto.Adapters.Postgres
end
