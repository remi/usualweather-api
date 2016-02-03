defmodule UsualWeather.CityController do
  use UsualWeather.Web, :controller
  alias UsualWeather.City

  def index(conn, _params) do
    cities = City |> Ecto.Query.order_by(asc: :name) |> Repo.all
    render(conn, "index.json", cities: cities)
  end
end
