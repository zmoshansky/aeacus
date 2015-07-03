use Mix.Config

config :aeacus, Aeacus.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  username: "postgres",
  password: "postgres",
  database: "aeacus_test",
  size: 10
