defmodule UsualWeather.Endpoint do
  use Phoenix.Endpoint, otp_app: :usual_weather

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug PlugCanonicalHost, canonical_host: get_in(Application.get_env(:usual_weather, UsualWeather.Endpoint), [:url, :host])

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head
  plug CORSPlug

  plug UsualWeather.Router
end
