defmodule UsualWeather.RootController do
  @moduledoc """
  The controller that responds to `/`
  """

  use Phoenix.Controller

  def show(conn, _params) do
    json conn, %{hello: "https://i.imgur.com/dxrWMTp.gif"}
  end
end
