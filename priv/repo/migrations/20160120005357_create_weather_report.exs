defmodule UsualWeather.Repo.Migrations.CreateWeatherReport do
  use Ecto.Migration

  def change do
    create table(:weather_reports) do
      add :month, :integer
      add :average_weather, :float
      add :city_id, references(:cities, on_delete: :nothing)

      timestamps
    end

    create index(:weather_reports, [:city_id])
  end
end
