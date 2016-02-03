defmodule WeatherReportGeneration do
  require Ecto.Query

  alias UsualWeather.Repo
  alias UsualWeather.City

  def generate! do
    Repo.all(Ecto.Query.from c in City)
    |> Enum.map(fn(city) ->
      Task.async fn -> generate_for_city!(city) end
    end)
    |> Enum.map(&(Task.await(&1, :infinity)))
  end

  defp generate_for_city!(city) do
    Repo.preload(city, :weather_captures)
    |> Map.get(:weather_captures)
    |> Enum.group_by(&(Map.get(&1, :month)))
    |> Enum.each(&(import_month_captures(city, &1)))
  end

  defp import_month_captures(city, {month, captures}) do
    # Generate reports
    attributes = %{month: month, average_weather: average_monthly_weather(captures)}
    Ecto.build_assoc(city, :weather_reports, attributes) |> Repo.insert!
  end

  defp average_monthly_weather(captures) do
    captures
    |> Enum.reduce(0, &(&1.average_weather + &2))
    |> Kernel./(length(captures))
    |> Float.round(1)
  end
end

WeatherReportGeneration.generate!
