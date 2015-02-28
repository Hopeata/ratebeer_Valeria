json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name
  json.year do
    json.name brewery.year
  end
  json.beerscount do
    json.name brewery.beers.count
  end
end
