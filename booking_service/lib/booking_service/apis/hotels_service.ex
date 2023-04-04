defmodule BookingService.APIs.HotelsService do
  use HTTPoison.Base

  alias BookingService.APIs
  require BookingService.APIs.Utils

  @expected_fields ~w(
    errors detail data id name stars capacity days country_iso hotel_id
  )

  def list_hotels() do
    "/hotels" |> get() |> APIs.Utils.extract_response(200)
  end

  def get_reservation(id) do
    "/reservations/#{id}" |> get() |> APIs.Utils.extract_response(200)
  end

  def create_reservation(params) do
    "/reservations"
    |> APIs.Utils.post_json(%{reservation: params})
    |> APIs.Utils.extract_response(201)
  end

  def cancel_reservation(id) do
    case delete("/reservations/#{id}") do
      {:ok, %{status_code: 204, body: nil}} -> :ok
      _otherwise -> :error
    end
  end

  def list_reservations() do
    "/reservations" |> get() |> APIs.Utils.extract_response(200)
  end

  def process_request_url(url) do
    # TODO: use fetch_env!
    # "http://hotels-service" <> url
    "http://localhost:4001/api" <> url
  end

  def process_response_body(body) do
    if body != "" do
      body
      |> Jason.decode!()
      |> APIs.Utils.atomize_json_keys(@expected_fields)
    end
  end
end
