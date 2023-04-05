defmodule FlightService.Setup do
  alias FlightService.Flights.Plane

  def seed do
    Ecto.Migrator.with_repo(FlightService.Repo, fn _ ->
      do_seed()
    end)
  end

  defp do_seed do
    unless FlightService.Repo.get_by(Plane, name: "Boieng 767") do
      FlightService.Repo.insert!(%Plane{
        name: "Boeing 767",
        capacity: 300
      })
    end

    unless FlightService.Repo.get_by(Plane, name: "Boieng 787") do
      FlightService.Repo.insert!(%Plane{
        name: "Boeing 787",
        capacity: 200
      })
    end

    unless FlightService.Repo.get_by(Plane, name: "Boieng 737") do
      FlightService.Repo.insert!(%Plane{
        name: "Boeing 737",
        capacity: 500
      })
    end
  end
end
