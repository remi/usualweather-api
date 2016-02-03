defmodule UsualWeather.CityController do
  use Phoenix.Controller

  require Ecto.Query

  alias UsualWeather.{City, Repo}

  def index(conn, _params) do
    cities = City |> Ecto.Query.order_by(asc: :name) |> Repo.all
    render(conn, "index.json", cities: cities)
  end
end
