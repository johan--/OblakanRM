json.extract! user, :id, :username, :created_at, :is_male
json.is_admin user.role == 'admin'
json.is_staff user.role == 'staff'
json.avatar user.avatar_url