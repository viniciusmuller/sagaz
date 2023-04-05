defmodule FlightServiceWeb.Router do
  use FlightServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FlightServiceWeb do
    pipe_through :api

    resources "/planes", PlaneController, except: [:new, :edit]
    resources "/flights", FlightController, except: [:new, :edit]
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :flight_service,
      swagger_file: "swagger.json"
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:flight_service, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: FlightServiceWeb.Telemetry
    end
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Flight Service"
      }
    }
  end
end
