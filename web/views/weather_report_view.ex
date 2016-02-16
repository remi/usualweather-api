defmodule UsualWeather.WeatherReportView do
  @moduledoc """
  Provides utilities to render weather reports.
  """

  use Phoenix.View, root: "web/templates"

  def render("index.json", %{weather_reports: weather_reports}) do
    rendered_reports = weather_reports
    |> render_many(UsualWeather.WeatherReportView,"weather_report.json")

    %{weather_reports: rendered_reports}
  end

  def render("weather_report.json", %{weather_report: weather_report}) do
    %{id: weather_report.id,
      month: weather_report.month,
      average_weather: weather_report.average_weather}
  end
end
