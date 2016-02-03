defmodule UsualWeather.Repo.Migrations.AddSlugColumnToCities do
  use Ecto.Migration

  def change do
    alter table(:cities) do
      add :slug, :text
    end
  end
end
