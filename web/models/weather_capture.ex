defmodule UsualWeather.WeatherCapture do
  @moduledoc """
  Describes the WeatherCapture schema.
  """

  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 4]

  alias UsualWeather.City

  schema "weather_captures" do
    field :month, :integer
    field :year, :integer
    field :average_weather, :float
    belongs_to :city, City

    timestamps
  end

  @required_fields ~w(month year average_weather)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
