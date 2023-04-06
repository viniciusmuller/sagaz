defmodule FlightServiceWeb.ApiSchemas do
  alias OpenApiSpex.Schema

  defmodule Plane do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Represents a specific plane",
      type: :object,
      properties: %{
        id: %Schema{type: :integer, description: "Plane ID"},
        name: %Schema{type: :string, description: "Plane name"},
        capacity: %Schema{type: :integer, description: "The plane's capacity"},
        inserted_at: %Schema{
          type: :string,
          description: "Creation timestamp",
          format: :"date-time"
        },
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :"date-time"}
      },
      required: [:name, :capacity],
      example: %{
        "id" => "a83d261f-d1e1-47cc-b7c2-caa4ca07bc07",
        "name" => "F22",
        "capacity" => 15,
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end

  defmodule PlaneRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Data used to create a new plane",
      type: :object,
      properties: %{
        plane: %Schema{anyOf: [Plane]}
      },
      example: %{
        "plane" => %{
          "name" => "F22",
          "capacity" => 15
        }
      }
    })
  end

  defmodule PlaneResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Response schema for single plane",
      type: :object,
      properties: %{
        data: Plane
      }
    })
  end

  defmodule Flight do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Represents a specific plane",
      type: :object,
      properties: %{
        id: %Schema{type: :integer, description: "Plane ID"},
        depart_time: %Schema{type: :utc_datetime, description: "Plane depart time"},
        arrival_time: %Schema{type: :utc_datetime, description: "Expected plane arrival time"},
        plane_id: %Schema{type: :string, description: "Plane ID"},
        from: %Schema{type: :string, description: "Source airport IATA code"},
        to: %Schema{type: :string, description: "Destination airport IATA code"},
        inserted_at: %Schema{
          type: :string,
          description: "Creation timestamp",
          format: :"date-time"
        },
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :"date-time"}
      },
      required: [:depart_time, :arrival_time, :plane_id, :from, :to],
      example: %{
        "id" => "a83d261f-d1e1-47cc-b7c2-caa4ca07bc07",
        "plane_id" => "84d3f082-b4e7-4de6-9fa9-4568d6690050",
        "depart_time" => "2023-04-05T12:00:00Z",
        "arrival_time" => "2023-04-05T14:00:00Z",
        "from" => "POA",
        "to" => "GRU",
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end

  defmodule FlightRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Data used to create a new flight",
      type: :object,
      properties: %{
        flight: %Schema{anyOf: [Flight]}
      },
      required: [:depart_time, :arrival_time, :plane_id, :from, :to],
      example: %{
        "flight" => %{
          "plane_id" => "84d3f082-b4e7-4de6-9fa9-4568d6690050",
          "depart_time" => "2023-04-05T12:00:00Z",
          "arrival_time" => "2023-04-05T14:00:00Z",
          "from" => "POA",
          "to" => "GRU",
          "inserted_at" => "2017-09-12T12:34:55Z",
          "updated_at" => "2017-09-13T10:11:12Z"
        }
      }
    })
  end

  defmodule FlightResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Response schema for single flight",
      type: :object,
      properties: %{
        data: Flight
      }
    })
  end
end
