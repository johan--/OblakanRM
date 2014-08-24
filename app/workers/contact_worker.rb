class ContactWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

  def perform(report_id)
    report = Report.find(report_id)
    ContactMailer.send_report_mail(report).deliver
  end
end