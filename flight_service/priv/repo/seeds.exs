# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FlightService.Repo.insert!(%FlightService.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

FlightService.Repo.insert!(%FlightService.Flights.Plane{
  name: "Boeing 767",
  capacity: 300
})

FlightService.Repo.insert!(%FlightService.Flights.Plane{
  name: "Boeing 787",
  capacity: 200
})

FlightService.Repo.insert!(%FlightService.Flights.Plane{
  name: "Boeing 737",
  capacity: 500
})
