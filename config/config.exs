# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :school_canteen,
  ecto_repos: [SchoolCanteen.Repo]

# Configures the endpoint
config :school_canteen, SchoolCanteen.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3x147pG44VoTswgOm94iCcDpVefCI7vsmiUAF5uJGV0OE0lBgquPwpZ9CNYoDrrf",
  render_errors: [view: SchoolCanteen.ErrorView, accepts: ~w(json)],
  pubsub: [name: SchoolCanteen.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :phoenix, :format_encoders,
  "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

# Guardian setup
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "SchoolCanteen",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET") || "gDJAXiDFaFKDPrxOXOIlHTmAXmlBlsQNko0naJlCyNSQ6AslIaOapfVu1wytMsCy",
  serializer: SchoolCanteen.GuardianSerializer