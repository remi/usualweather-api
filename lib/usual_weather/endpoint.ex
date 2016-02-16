defmodule UsualWeather.Endpoint do
  @moduledoc """
  The main application endpoint.
  """

  use Phoenix.Endpoint, otp_app: :usual_weather

  alias UsualWeather.{Endpoint, Router}

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  host = get_in(Application.get_env(:usual_weather, Endpoint), [:url, :host])
  plug PlugCanonicalHost, canonical_host: host

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head
  plug CORSPlug

  plug Router
end
