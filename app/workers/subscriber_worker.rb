class SubscriberWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

  def perform(subscriber_id, method, options = {})
    subscriber = Subscriber.find(subscriber_id)
    SubscriberMailer.send(method, subscriber, options).deliver
  end
end