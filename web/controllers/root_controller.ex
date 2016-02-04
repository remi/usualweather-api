defmodule UsualWeather.RootController do
  use Phoenix.Controller

  def show(conn, _params) do
    json conn, %{secret: "https://i.imgur.com/dxrWMTp.gif"}
  end
end
