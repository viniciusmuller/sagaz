defmodule ReservationService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ReservationServiceWeb.Telemetry,
      # Start the Ecto repository
      ReservationService.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ReservationService.PubSub},
      # Start the Endpoint (http/https)
      ReservationServiceWeb.Endpoint
      # Start a worker by calling: ReservationService.Worker.start_link(arg)
      # {ReservationService.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReservationService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReservationServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
