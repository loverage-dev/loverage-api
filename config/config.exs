# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :loverage_api,
  namespace: Loverage,
  ecto_repos: [Loverage.Repo]

# Configures the endpoint
config :loverage_api, LoverageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EVjdHBQWv2LEKWNxbdeSmEZrY538sCR80kdj/lfTfKjVHouQTdwC+zpRlp4ZTsTk",
  render_errors: [view: LoverageWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Loverage.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
