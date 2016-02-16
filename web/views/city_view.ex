defmodule UsualWeather.CityView do
  @moduledoc """
  Provides utilities to render weather reports.
  """

  use Phoenix.View, root: "web/templates"

  def render("index.json", %{cities: cities}) do
    rendered_cities = cities
    |> render_many(UsualWeather.CityView, "city.json")

    %{cities: rendered_cities}
  end

  def render("city.json", %{city: city}) do
    %{id: city.slug,
      name: city.name}
  end
end
