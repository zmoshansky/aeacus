# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for third-
# party users, it should be done in your mix.exs file.

config :aeacus, Aeacus,
  repo: Aeacus.Test.Repo,
  model: Aeacus.Test.MockResource

config :aeacus, Aeacus.Test.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  username: "postgres",
  password: "postgres",
  database: "aeacus_test",
  size: 10

config :logger, :console,
  level: :warn,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:user_id]
