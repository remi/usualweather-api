defmodule UsualWeather.WeatherReportView do
  use UsualWeather.Web, :view

  def render("index.json", %{weather_reports: weather_reports}) do
    %{weather_reports: render_many(weather_reports, UsualWeather.WeatherReportView, "weather_report.json")}
  end

  def render("weather_report.json", %{weather_report: weather_report}) do
    %{id: weather_report.id, month: weather_report.month, average_weather: weather_report.average_weather}
  end
end
