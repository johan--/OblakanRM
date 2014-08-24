json.extract! comment, :id, :created_at, :content, :commentable_type, :commentable_id, :is_deleted
json.user comment.user_id
json.user_id comment.user_id