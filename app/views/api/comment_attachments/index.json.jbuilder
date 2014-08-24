json.array!(@comment_attachments) do |comment_attachment|
  json.extract! comment_attachment, 
  json.url comment_attachment_url(comment_attachment, format: :json)
end
