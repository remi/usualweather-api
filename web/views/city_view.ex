defmodule UsualWeather.CityView do
  use Phoenix.View, root: "web/templates"

  def render("index.json", %{cities: cities}) do
    %{cities: render_many(cities, UsualWeather.CityView, "city.json")}
  end

  def render("city.json", %{city: city}) do
    %{id: city.slug, name: city.name}
  end
end
