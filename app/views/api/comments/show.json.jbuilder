json.comment do
  json.partial! @comment, partial: 'api/comments/comment', as: :comment
end