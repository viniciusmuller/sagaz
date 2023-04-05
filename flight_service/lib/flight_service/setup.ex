defmodule FlightService.Setup do
  alias FlightService.Flights

  def seed do
    Ecto.Migrator.with_repo(FlightService.Repo, fn _ ->
      do_seed()
    end)
  end

  defp do_seed do
    unless FlightService.Repo.get_by(Flights.Plane, name: n = "Boeing 767") do
      FlightService.Repo.insert!(%Flights.Plane{
        name: n,
        capacity: 300
      })
    end

    unless FlightService.Repo.get_by(Flights.Plane, name: n = "Boeing 787") do
      FlightService.Repo.insert!(%Flights.Plane{
        name: n,
        capacity: 200
      })
    end

    unless FlightService.Repo.get_by(Flights.Plane, name: n = "Boeing 737") do
      FlightService.Repo.insert!(%Flights.Plane{
        name: n,
        capacity: 500
      })
    end
  end
end
