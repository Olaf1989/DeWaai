json.array!(@courses) do |course|
  json.extract! course, :id, :startdate, :enddate
  json.url course_url(course, format: :json)
end
