# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HotelService.Repo.insert!(%HotelService.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

HotelService.Repo.insert!(%HotelService.Hotels.Hotel{
  name: "Brazilian Hotel",
  country_iso: "BR",
  stars: 4,
  capacity: 50
})

HotelService.Repo.insert!(%HotelService.Hotels.Hotel{
  name: "New York Hotel",
  country_iso: "US",
  stars: 5,
  capacity: 100
})

HotelService.Repo.insert!(%HotelService.Hotels.Hotel{
  name: "Tokio Hotel",
  country_iso: "JP",
  stars: 4,
  capacity: 75
})
