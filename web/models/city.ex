defmodule UsualWeather.City do
  @moduledoc """
  Describes the City schema.
  """

  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 4, get_field: 2, put_change: 3]

  schema "cities" do
    field :slug, :string
    field :name, :string
    has_many :weather_reports, UsualWeather.WeatherReport
    has_many :weather_captures, UsualWeather.WeatherCapture

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> generate_slug_from(:name)
  end

  defp generate_slug_from(changeset, base_field) do
    base_value = get_field(changeset, base_field)
    slug = Slugger.slugify_downcase(base_value)

    put_change(changeset, :slug, slug)
  end
end
