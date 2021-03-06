defmodule DownloadManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor, [topologies(), [name: BackgroundJob.ClusterSupervisor]]},
      DownloadManagerWeb.Telemetry,
      {Phoenix.PubSub, name: DownloadManager.PubSub},
      DownloadManager.HordeRegistry,
      DownloadManager.HordeSupervisor,
      DownloadManager.NodeObserver,
      DownloadManagerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: DownloadManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    DownloadManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp topologies do
    [
      background_job: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]
  end
end
