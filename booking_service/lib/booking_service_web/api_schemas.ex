defmodule BookingServiceWeb.ApiSchemas do
  alias OpenApiSpex.Schema

  defmodule Booking do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "Booking ID"},
        flight_id: %Schema{type: :string, description: "Flight ID"},
        reservation_id: %Schema{type: :string, description: "Reservation ID"},
        inserted_at: %Schema{
          type: :string,
          description: "Creation timestamp",
          format: :"date-time"
        },
        updated_at: %Schema{type: :string, description: "Update timestamp", format: :"date-time"}
      },
      example: %{
        "id" => "a83d261f-d1e1-47cc-b7c2-caa4ca07bc07",
        "flight_id" => "383eada9-b275-473c-a836-3a7926a2f50b",
        "reservation_id" => "ad9dfdf0-78aa-4c38-aeff-f17b10f21d11",
        "inserted_at" => "2023-04-12T12:34:55Z",
        "updated_at" => "2023-04-13T10:11:12Z"
      }
    })
  end

  defmodule BookingParams do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Required data to book a travel",
      type: :object,
      properties: %{
        hotel_id: %Schema{type: :string, description: "Hotel ID"},
        days: %Schema{type: :integer, description: "Total accomodation days"},
        plane_id: %Schema{type: :string, description: "Plane ID"},
        from: %Schema{type: :string, description: "Source airport IATA code"},
        to: %Schema{type: :string, description: "Destination airport IATA code"},
        depart_time: %Schema{type: :utc_datetime, description: "Plane depart time"},
        arrival_time: %Schema{type: :utc_datetime, description: "Expected plane arrival time"}
      },
      required: [:hotel_id, :days, :plane_id, :from, :to, :depart_time, :arrival_time],
      example: %{
        "hotel_id" => "1f1cbef0-e429-446f-a91a-23396fc8528c",
        "days" => 7,
        "plane_id" => "b15d5d75-87ca-4bb9-a543-efb68c83ef7d",
        "from" => "POA",
        "to" => "GRU",
        "depart_time" => "2023-04-05T12:00:00Z",
        "arrival_time" => "2023-04-05T14:00:00Z"
      }
    })
  end

  defmodule CreateBooking do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        booking: BookingParams
      },
      example: %{
        "booking" => %{
          "hotel_id" => "1f1cbef0-e429-446f-a91a-23396fc8528c",
          "days" => 7,
          "plane_id" => "b15d5d75-87ca-4bb9-a543-efb68c83ef7d",
          "from" => "POA",
          "to" => "GRU",
          "depart_time" => "2023-04-05T12:00:00Z",
          "arrival_time" => "2023-04-05T14:00:00Z"
        }
      }
    })
  end

  defmodule UpdateBooking do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        booking: %Schema{anyOf: [Booking]}
      },
      example: %{
        "booking" => %{
          "reservation_id" => "531a3abb-df5f-4477-815c-3401af974208",
          "flight_id" => "7def7cdd-59ec-4e63-978d-2e220636b85d"
        }
      }
    })
  end

  defmodule BookingResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      description: "Response schema for a single booking",
      type: :object,
      properties: %{
        data: Booking
      }
    })
  end
end
