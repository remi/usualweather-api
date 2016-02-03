use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :usual_weather, UsualWeather.Endpoint,
  debug_errors: true,
  code_reloader: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :usual_weather, UsualWeather.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "usual_weather_dev",
  hostname: "localhost",
  pool_size: 10,
  pool_timeout: 36000,
  timeout: 36000
