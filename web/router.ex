defmodule UsualWeather.Router do
  use UsualWeather.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UsualWeather do
    pipe_through :api

    get "/cities", CityController, :index
    get "/weather-reports", WeatherReportController, :show
  end
end
