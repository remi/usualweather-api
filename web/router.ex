defmodule UsualWeather.Router do
  @moduledoc """
  The main application router.
  """

  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UsualWeather do
    pipe_through :api

    get "/", RootController, :show
    get "/cities", CityController, :index
    get "/weather-reports", WeatherReportController, :show
  end
end
