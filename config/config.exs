use Mix.Config

# Configures the endpoint
config :download_manager, DownloadManagerWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000")
  ],
  url: [host: "localhost"],
  secret_key_base: "d5NAy0A6oIY/cpc+LF831rbXtezzg89x0Iz9C840AI2gTsrnJB1W+GBvZdDV1+Hb",
  render_errors: [view: DownloadManagerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DownloadManager.PubSub,
  live_view: [signing_salt: "uEyG1VRH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
