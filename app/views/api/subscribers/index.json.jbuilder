json.subscribers (@subscribers) do |subscriber|
  json.extract! subscriber, :id, :subscribe_type, :subscribe_id, :code
  json.user subscriber.user_id
  json.user_id subscriber.user_id
  json.url api_subscriber_url(subscriber, format: :json)
end
