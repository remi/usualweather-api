defmodule WeatherCaptureImport do
  alias UsualWeather.{City, Repo}

  @data_directory System.get_env("DATA_DIRECTORY")

  @cities %{
    "Toronto" => ~r/toronto/i,
    "Montreal" => ~r/montreal/i,
    "Vancouver" => ~r/vancouver/i,
    "Ottawa" => ~r/ottawa/i,
    "Calgary" => ~r/calgary/i,
    "Edmonton" => ~r/edmonton/i,
    "Quebec City" => ~r/quebec/i,
    "Winnipeg" => ~r/winnipeg/i,
    "Hamilton" => ~r/hamilton/i,
    "Kitchener" => ~r/kitchener/i,
    "London" => ~r/london/i,
    "St. Catharines" => ~r/st.? catharines/i,
    "Halifax" => ~r/halifax/i,
    "Oshawa" => ~r/oshawa/i,
    "Victoria" => ~r/victoria/i,
    "Windsor" => ~r/windsor/i,
    "Saskatoon" => ~r/saskatoon/i,
    "Regina" => ~r/regina/i,
    "Sherbrooke" => ~r/sherbrooke/i,
    "St. John’s" => ~r/st.? john'?s/i,
    "Barrie" => ~r/barrie/i,
    "Kelowna" => ~r/kelowna/i,
    "Abbotsford" => ~r/abbotsford/i,
    "Sudbury" => ~r/sudbury/i,
    "Kingston" => ~r/kingston/i,
    "Saguenay" => ~r/saguenay/i,
    "Trois-Rivières" => ~r/trois-rivi[eè]res/i,
    "Guelph" => ~r/guelph/i,
    "Moncton" => ~r/moncton/i,
    "Brantford" => ~r/brantford/i,
    "Thunder Bay" => ~r/thunder bay/i,
    "Peterborough" => ~r/peterborough/i,
    "Lethbridge" => ~r/lethbridge/i,
    "Chatham-Kent" => ~r/chatham-kent/i,
    "Cape Breton" => ~r/cape breton/i,
    "Kamloops" => ~r/kamloops/i,
    "Nanaimo" => ~r/nanaimo/i,
    "Fredericton" => ~r/fredericton/i,
    "Belleville" => ~r/belleville/i,
    "Chilliwack" => ~r/chilliwack/i,
    "Red Deer" => ~r/red deer/i,
    "Sarnia" => ~r/sarnia/i,
    "Drummondville" => ~r/drummondville/i,
    "Prince George" => ~r/prince george/i,
    "Sault Ste. Marie" => ~r/sault ste. marie/i,
    "Granby" => ~r/granby/i,
    "Kawartha Lakes" => ~r/kawartha lakes/i,
    "Medicine Hat" => ~r/medicine hat/i,
    "Charlottetown" => ~r/charlottetown/i,
    "North Bay" => ~r/north bay/i,
    "Norfolk" => ~r/norfolk/i,
    "Cornwall" => ~r/cornwall/i,
    "Vernon" => ~r/vernon/i,
    "Saint-Hyacinthe" => ~r/saint-hyacinthe/i,
    "Courtenay" => ~r/courtenay/i,
    "Grande Prairie" => ~r/grande prairie/i,
    "Shawinigan" => ~r/shawinigan/i,
    "Brandon" => ~r/brandon/i,
    "Rimouski" => ~r/rimouski/i,
    "Leamington" => ~r/leamington/i,
    "Sorel-Tracy" => ~r/sorel-tracy/i,
    "Joliette" => ~r/joliette/i,
    "Victoriaville" => ~r/victoriaville/i,
    "Truro" => ~r/truro/i,
    "Duncan" => ~r/duncan/i,
    "Timmins" => ~r/timmins/i,
    "Prince Albert" => ~r/prince albert/i,
    "Penticton" => ~r/penticton/i,
    "Rouyn-Noranda" => ~r/rouyn-noranda/i,
    "Orillia" => ~r/orillia/i,
    "Salaberry-de-Valleyfield" => ~r/salaberry-de-valleyfield/i,
    "Brockville" => ~r/brockville/i,
    "Woodstock" => ~r/woodstock/i,
    "Campbell River" => ~r/campbell river/i,
    "New Glasgow" => ~r/new glasgow/i,
    "Midland" => ~r/midland/i,
    "Moose Jaw" => ~r/moose jaw/i,
    "Bathurst" => ~r/bathurst/i,
    "Val-d’Or" => ~r/val-d['\s]?or/i,
    "Alma" => ~r/alma/i,
    "Owen Sound" => ~r/owen sound/i,
    "Stratford" => ~r/stratford/i,
    "Lloydminster" => ~r/lloydminster/i,
    "Baie-Comeau" => ~r/baie-comeau/i,
    "Sept-Îles" => ~r/sept-[îi]les/i,
    "Miramichi" => ~r/miramichi/i,
    "Thetford Mines" => ~r/thetford mines/i,
    "Parksville" => ~r/parksville/i,
    "Rivière-du-Loup" => ~r/rivi[eè]re-du-loup/i,
    "Corner Brook" => ~r/corner brook/i,
    "Centre Wellington" => ~r/centre wellington/i,
    "Whitehorse" => ~r/whitehorse/i,
    "Okotoks" => ~r/okotoks/i,
    "Edmundston" => ~r/edmundston/i,
    "Collingwood" => ~r/collingwood/i,
    "Yellowknife" => ~r/yellowknife/i,
    "Cobourg" => ~r/cobourg/i,
    "Matane" => ~r/matane/i,
    "Squamish" => ~r/squamish/i,
    "Camrose" => ~r/camrose/i,
    "Amos" => ~r/amos/i
  }

  def import! do
    case File.ls(@data_directory) do
      {:ok, files} ->
        files
        |> Enum.filter(&(Regex.match?(~r/.+\.csv/, &1)))
        |> Enum.map(&extract_data_from_file/1)
        |> Enum.map(fn(file) ->
          Task.async fn -> import_file(file) end
        end)
        |> Enum.map(&(Task.await(&1, :infinity)))
      _ ->
        IO.puts("Cannot list files in #{@data_directory}")
    end
  end

  defp extract_data_from_file(file) do
    Regex.named_captures(~r/(?<year>\d{4})-(?<month>\d{2})/, file)
    |> Map.put("file", "#{@data_directory}/#{file}")
  end

  defp import_file(%{"month" => month, "year" => year, "file" => file}) do
    File.stream!(file)
    |> CSV.decode
    |> Enum.each(&(process_line(month, year, &1)))
  end

  defp process_line(month, year, list) do
    city_name = Enum.at(list, 0)
    average_weather = Enum.at(list, 4)

    # Import captures
    import_capture(month, year, find_city(city_name), average_weather)
  end

  # Skip captures from unsupported city or without an average
  defp import_capture(_month, _year, _city, ""), do: nil
  defp import_capture(_month, _year, nil, _average), do: nil

  defp import_capture(month, year, city, average_weather) do
    IO.puts("Importing #{month}/#{year} for #{city.name} (avg #{average_weather})")

    attributes = %{
      month: String.to_integer(month),
      year: String.to_integer(year),
      average_weather: String.to_float(average_weather)
    }

    Ecto.build_assoc(city, :weather_captures, attributes) |> Repo.insert!
  end

  defp find_city(name) do
    case find_supported_city(name) do
      {city_name, _} -> Repo.get_by(City, name: city_name)
      _ -> nil
    end
  end

  defp find_supported_city(name) do
    Enum.find(@cities, fn({_, regex}) ->
      Regex.match?(regex, name)
    end)
  end
end

WeatherCaptureImport.import!
