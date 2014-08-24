json.subscriber do
    json.extract! @subscriber, :id, :subscribe_type, :subscribe_id, :code
    json.user @subscriber.user_id
    json.user_id @subscriber.user_id
    json.created_at @subscriber.created_at
end
