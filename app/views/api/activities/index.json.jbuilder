json.array!(@activities) do |activity|
  json.extract! activity, :id, :key
  json.url api_activity_url(activity, format: :json)
end
