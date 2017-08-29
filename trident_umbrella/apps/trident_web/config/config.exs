# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :trident_web,
  namespace: TridentWeb

# Configures the endpoint
config :trident_web, TridentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VdVXFUWDc4G8P8pIxh3NfQm489SArcuxWN0n017vlyZeATXi1qrch7nYSZN7EuY1",
  render_errors: [view: TridentWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TridentWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :trident_web, :generators,
  context_app: :trident

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
