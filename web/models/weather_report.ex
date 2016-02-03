defmodule UsualWeather.WeatherReport do
  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 4]

  alias UsualWeather.City

  schema "weather_reports" do
    field :month, :integer
    field :average_weather, :float
    belongs_to :city, City

    timestamps
  end

  @required_fields ~w(month average_weather)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
