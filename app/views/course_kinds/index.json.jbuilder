json.array!(@course_kinds) do |course_kind|
  json.extract! course_kind, :id, :name, :price
  json.url course_kind_url(course_kind, format: :json)
end
