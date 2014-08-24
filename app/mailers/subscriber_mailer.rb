class SubscriberMailer < ActionMailer::Base
  default from: 'robot@oblakan.ru'
  layout 'mailer'

  @delivery_options = {
      user_name: 'robot@oblakan.ru',
      password: '6yP8j4MYs3BJ'
  }

  def create_notify_mail(subscriber, options)
    set_params(subscriber)

    mail(to: @user.email, subject: "Вы успешно подписались на события проблемы №#{@report.id}", delivery_method_options: @delivery_options)
  end

  def update_notify_mail(subscriber, options)
    set_params(subscriber)

    mail(to: @user.email, subject: "Обновление проблемы №#{@report.id}", delivery_method_options: @delivery_options)
  end

  def delete_notify_mail(subscriber, options)
    set_params(subscriber)

    mail(to: @user.email, subject: "Удаление подписки от проблемы №#{@report.id}", delivery_method_options: @delivery_options)
  end

  def comment_notify_mail(subscriber, options)
    set_params(subscriber)
    @comment = Comment.find(options['comment_id'])

    mail(to: @user.email, subject: "Уведомление о комментарии в проблеме №#{@report.id}", delivery_method_options: @delivery_options)
  end

  private

    def set_params(subscriber)
      @subscriber = subscriber
      @user = @subscriber.user
      @report = Report.find(@subscriber.subscribe_id)
    end
end