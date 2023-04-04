defmodule BookingService.APIs.HotelsService do
  use HTTPoison.Base

  alias BookingService.APIs
  require BookingService.APIs.Utils

  @expected_fields ~w(
    errors detail data id name stars capacity days country_iso hotel_id
  )

  def process_request_url(url) do
    # TODO: use fetch_env!
    # "http://hotels-service" <> url
    "http://localhost:4000/api" <> url
  end

  def list_hotels() do
    get("/hotels")
  end

  def create_reservation(params) do
    APIs.Utils.post_json("/reservations", %{reservation: params})
  end

  def delete_reservation(id) do
    delete("/reservations/#{id}")
  end

  def list_reservations() do
    get("/reservations")
  end

  def process_response_body(body) do
    if body != "" do
      body
      |> Jason.decode!()
      |> APIs.Utils.atomize_json_keys(@expected_fields)
    end
  end
end
