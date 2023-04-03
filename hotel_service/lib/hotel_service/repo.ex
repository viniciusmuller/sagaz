defmodule HotelService.Repo do
  use Ecto.Repo,
    otp_app: :hotel_service,
    adapter: Ecto.Adapters.Postgres
end
