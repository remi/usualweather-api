defmodule UsualWeather.CityController do
  @moduledoc """
  The controller for cities routes.
  """

  use Phoenix.Controller

  require Ecto.Query

  alias Ecto.Query
  alias UsualWeather.{City, Repo}

  def index(conn, _params) do
    cities = City |> Query.order_by(asc: :name) |> Repo.all
    render(conn, "index.json", cities: cities)
  end
end
