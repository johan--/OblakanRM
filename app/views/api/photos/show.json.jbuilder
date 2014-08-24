json.photo do
    json.extract! @photo, :id, :uid, :original_url, :medium_thumb, :small_thumb, :created_at, :entity_type, :entity_id, :created_at
end
