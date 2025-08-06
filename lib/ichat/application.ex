defmodule Ichat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      IchatWeb.Telemetry,
      Ichat.Repo,
      {DNSCluster, query: Application.get_env(:ichat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ichat.PubSub},
      # Start a worker by calling: Ichat.Worker.start_link(arg)
      # {Ichat.Worker, arg},
      # Start to serve requests, typically the last entry
      IchatWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ichat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IchatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
