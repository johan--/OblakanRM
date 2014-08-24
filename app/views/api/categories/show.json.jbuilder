json.category do
    json.extract! @category, :id, :title, :description, :icon, :parent_id, :created_at
end
