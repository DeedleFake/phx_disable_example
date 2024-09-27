defmodule PhxDisableExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxDisableExampleWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:phx_disable_example, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxDisableExample.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxDisableExample.Finch},
      # Start a worker by calling: PhxDisableExample.Worker.start_link(arg)
      # {PhxDisableExample.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxDisableExampleWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxDisableExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxDisableExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
