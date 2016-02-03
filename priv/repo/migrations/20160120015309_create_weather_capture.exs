defmodule UsualWeather.Repo.Migrations.CreateWeatherCapture do
  use Ecto.Migration

  def change do
    create table(:weather_captures) do
      add :month, :integer
      add :year, :integer
      add :average_weather, :float
      add :city_id, references(:cities, on_delete: :nothing)

      timestamps
    end

    create index(:weather_captures, [:city_id])
  end
end
