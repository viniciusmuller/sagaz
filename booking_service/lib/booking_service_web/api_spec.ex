defmodule BookingServiceWeb.ApiSpec do
  alias OpenApiSpex.{Info, OpenApi, Paths}
  alias BookingServiceWeb.Router

  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      info: %Info{
        title: "Booking Service",
        version: "1.0"
      },
      # Populate the paths from a phoenix router
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules() # Discover request/response schemas from path specs
  end
end
