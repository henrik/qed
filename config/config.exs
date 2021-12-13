# This file is responsible for configuring your application
# and its dependencies.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :qed, QEDWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "303kJ4fMvpY23vWrFWarHcNN5Ypr4WQ4gr7YFGv/iFqqiOF/ae6zuB/3qqHmwjAu",
  render_errors: [view: QEDWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: QED.PubSub,
  live_view: [signing_salt: "itZIiOXE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
