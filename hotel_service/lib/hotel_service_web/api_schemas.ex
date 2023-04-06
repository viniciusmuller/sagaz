defmodule HotelServiceWeb.ApiSchemas do
  alias OpenApiSpex.Schema

  defmodule Hotel do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Represents a specific hotel",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "Hotel's ID"},
        name: %Schema{type: :string, description: "Hotel's name"},
        capacity: %Schema{type: :integer, description: "The hotels's max capacity"},
        country_iso: %Schema{type: :string, description: "Hotel's country ISO code"},
        stars: %Schema{type: :integer, description: "The hotels's number of stars"},
        inserted_at: %Schema{
          type: :string,
          description: "Creation timestamp",
          format: :"date-time"
        },
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :"date-time"}
      },
      example: %{
        "id" => "a83d261f-d1e1-47cc-b7c2-caa4ca07bc07",
        "name" => "Great Hotel",
        "capacity" => 100,
        "country_iso" => "BR",
        "stars" => 5,
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end

  defmodule HotelRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Data used to create a new hotel",
      type: :object,
      properties: %{
        hotel: %Schema{anyOf: [Hotel]}
      },
      required: [:name, :capacity, :country_iso, :stars],
      example: %{
        "hotel" => %{
          "name" => "Great Hotel",
          "capacity" => 100,
          "country_iso" => "BR",
          "stars" => 5
        }
      }
    })
  end

  defmodule HotelResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Response schema for single hotel",
      type: :object,
      properties: %{
        data: Hotel
      }
    })
  end

  defmodule Reservation do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Represents a specific reservation",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "Reservation's ID"},
        days: %Schema{type: :integer, description: "Accomodation days"},
        hotel_id: %Schema{type: :string, description: "Hotel's ID"},
        inserted_at: %Schema{
          type: :string,
          description: "Creation timestamp",
          format: :"date-time"
        },
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :"date-time"}
      },
      example: %{
        "id" => "a83d261f-d1e1-47cc-b7c2-caa4ca07bc07",
        "hotel_id" => "c12f1f7a-8b9d-4db9-a98c-72a57fdaa7e1",
        "days" => 7,
        "inserted_at" => "2017-09-12T12:34:55Z",
        "updated_at" => "2017-09-13T10:11:12Z"
      }
    })
  end

  defmodule ReservationRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Data used to create a new reservation",
      type: :object,
      properties: %{
        reservation: %Schema{anyOf: [Reservation]}
      },
      required: [:days, :hotel_id],
      example: %{
        "reservation" => %{
          "days" => 7,
          "hotel_id" => "c12f1f7a-8b9d-4db9-a98c-72a57fdaa7e1"
        }
      }
    })
  end

  defmodule ReservationResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Response schema for single reservation",
      type: :object,
      properties: %{
        data: Reservation
      }
    })
  end
end
