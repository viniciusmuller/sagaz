defmodule HotelServiceWeb.Router do
  use HotelServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: HotelServiceWeb.ApiSpec
  end

  scope "/api", HotelServiceWeb do
    pipe_through :api

    resources "/hotels", HotelController, except: [:new, :edit]
    resources "/reservations", ReservationController, except: [:new, :edit]
  end

  scope "/api" do
    pipe_through :api

    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
    get "/swagger", OpenApiSpex.Plug.SwaggerUI, path: "/api/openapi"
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:hotel_service, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: HotelServiceWeb.Telemetry
    end
  end
end
