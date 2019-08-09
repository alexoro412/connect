# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :connect, ConnectWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JXTFWNt7/PrAezn5iThT7EPpAyiGgvODlDP5nDI1bq1aP8g3fbqSj2dh7zc/FMmA",
  render_errors: [view: ConnectWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Connect.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
