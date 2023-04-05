# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :flight_service, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: FlightServiceWeb.Router,     # phoenix routes will be converted to swagger paths
    ]
  }

config :phoenix_swagger, json_library: Jason

config :flight_service,
  ecto_repos: [FlightService.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :flight_service, FlightServiceWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: FlightServiceWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: FlightService.PubSub,
  live_view: [signing_salt: "utl5Jy0o"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
