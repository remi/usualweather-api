defmodule UsualWeather.WeatherCapture do
  use UsualWeather.Web, :model

  schema "weather_captures" do
    field :month, :integer
    field :year, :integer
    field :average_weather, :float
    belongs_to :city, UsualWeather.City

    timestamps
  end

  @required_fields ~w(month year average_weather)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
