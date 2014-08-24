json.extract! report, :id, :title, :description, :address, :longitude, :latitude, :created_at,
              :photos_count, :comments_count

json.start_photo report.start_photo_id
json.start_photo_id report.start_photo_id
json.end_photo report.end_photo_id
json.user report.user.id
json.user_id report.user_id

json.photos do
  json.array! report.photos.map(&:id)
end

json.comments do
  json.array! report.comments.map(&:id)
end

json.subscribers_count report.subscribers_count

json.near do
  json.array! report.near.map {|a| a.id}
end
json.is_subscribed report.is_subscribed?(current_user)
json.status report.status_id
json.status_id report.status_id
json.category report.category_id
json.category_id report.category_id