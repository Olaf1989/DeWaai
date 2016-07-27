json.array!(@ships) do |ship|
  json.extract! ship, :id, :classtype, :name, :damage
  json.url ship_url(ship, format: :json)
end
