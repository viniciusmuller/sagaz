defmodule HotelService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HotelServiceWeb.Telemetry,
      # Start the Ecto repository
      HotelService.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: HotelService.PubSub},
      # Start the Endpoint (http/https)
      HotelServiceWeb.Endpoint
      # Start a worker by calling: HotelService.Worker.start_link(arg)
      # {HotelService.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HotelService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HotelServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
