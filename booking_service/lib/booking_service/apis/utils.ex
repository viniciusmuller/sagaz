defmodule BookingService.APIs.Utils do
  def atomize_json_keys(json, expected_fields) when is_map(json) do
    json
    |> Map.take(expected_fields)
    |> Map.new(fn {k, v} -> {String.to_atom(k), atomize_json_keys(v, expected_fields)} end)
  end

  def atomize_json_keys(json, expected_fields) when is_list(json) do
    Enum.map(json, &atomize_json_keys(&1, expected_fields))
  end

  def atomize_json_keys(json, _), do: json

  defmacro post_json(url, body) do
    quote do
      post(
        unquote(url),
        Jason.encode!(unquote(body)),
        [{"Content-Type", "application/json"}]
      )
    end
  end
end
