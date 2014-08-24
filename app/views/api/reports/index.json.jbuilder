json.meta do
  json.total_pages @reports.total_pages
end

json.reports @reports, partial: 'api/reports/report', as: :report
json.users @users, partial: 'api/users/user', as: :user
json.photos @photos, partial: 'api/photos/photo', as: :photo

json.cache! @statuses, expires_in: 3.day do
  json.statuses @statuses, partial: 'api/statuses/status', as: :status
end

json.cache! @categories, expires_in: 1.day do
  json.categories @categories, partial: 'api/categories/category', as: :category
end