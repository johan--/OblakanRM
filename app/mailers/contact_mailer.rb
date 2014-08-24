class ContactMailer < ActionMailer::Base
  default from: 'report_map@oblakan.ru'
  layout 'mailer'

  def send_report_mail(report)
    @report = report

    delivery_options = {
        user_name: ENV['REPORT_EMAIL_USER'],
        password: ENV['REPORT_EMAIL_PASSWORD']
    }

    mail = if Rails.env.production?
             'informotdel@list.ru'
           else
             'constxife@icloud.com'
           end
    mail(to: "#{mail},report_map@oblakan.ru", subject: "№#{@report.id}: #{@report.title}", delivery_method_options: delivery_options)
  end
end