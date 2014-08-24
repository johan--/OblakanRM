url = if Rails.env.production?
        'redis://localhost:6379/12'
      else
        'redis://selena:6379/12'
      end
namespace = 'reportrm'

Sidekiq.configure_server do |config|
  config.redis = { url: url, namespace: namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { url: url, namespace: namespace }
end