defmodule BookingService.APIs.FlightsService do
  use HTTPoison.Base

  alias BookingService.APIs
  require BookingService.APIs.Utils

  @expected_fields ~w(
    errors detail data id name capacity from to 
    depart_time arrival_time plane_id
  )

  def get_flight(id) do
    "/flights/#{id}" |> get() |> APIs.Utils.extract_response()
  end

  def get_plane(id) do
    "/planes/#{id}" |> get() |> APIs.Utils.extract_response()
  end

  def list_planes() do
    "/planes" |> get() |> APIs.Utils.extract_response()
  end

  def list_booked_flights() do
    "/flights" |> get() |> APIs.Utils.extract_response()
  end

  def book_flight(params) do
    "/flights"
    |> APIs.Utils.post_json(%{flight: params})
    |> APIs.Utils.extract_response()
  end

  def unbook_flight(id) do
    case delete("/flights/#{id}") do
      {:ok, %{status_code: 204, body: nil}} -> :ok
      _otherwise -> :error
    end
  end

  def process_request_url(url) do
    host = System.fetch_env!("HOTEL_SERVICE_HOST")
    "#{host}/api#{url}"
  end

  def process_response_body(body) do
    if body != "" do
      body
      |> Jason.decode!()
      |> APIs.Utils.atomize_json_keys(@expected_fields)
    end
  end
end
