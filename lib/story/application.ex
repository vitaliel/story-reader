defmodule Story.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StoryWeb.Telemetry,
      # Story.Repo,
      {DNSCluster, query: Application.get_env(:story, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Story.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Story.Finch},
      # Start a worker by calling: Story.Worker.start_link(arg)
      # {Story.Worker, arg},
      # Start to serve requests, typically the last entry
      StoryWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Story.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StoryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
