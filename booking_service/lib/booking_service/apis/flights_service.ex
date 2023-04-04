defmodule BookingService.APIs.FlightsService do
  use HTTPoison.Base

  alias BookingService.APIs

  @expected_fields ~w(
    errors detail data
  )

  def process_request_url(url) do
    # TODO: use fetch_env!
    # "http://flights-service" <> url
    "http://localhost:4000/api" <> url
  end

  def process_response_body(body) do
    body
    |> Jason.decode!()
    |> APIs.Utils.atomize_json_keys(@expected_fields)
  end
end
