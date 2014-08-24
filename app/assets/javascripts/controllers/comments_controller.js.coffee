# for more details see: http://emberjs.com/guides/controllers/

OblakanRM.CommentsController = Ember.ArrayController.extend
  sortProperties: ['created_at']
  sortAscending: false
  itemController: 'comment'
  needs: ['report']
  report: Ember.computed.alias('controllers.report')
  current_user: OblakanRM.get_current_user()

  validate: ->
    rules = {
      content: {
        required: true
      }
    }

    form = $('form.comments')
    form.validate
      onfocusout: false
      onkeyup: true
      onclick: false
      rules:
        rules
      messages:
        content:
          required: 'Нужно что-то написать, прежде чем отправлять комментарий'
    form.valid()

  actions:
    comment_submit: ->
      if @validate()
        button = $('#comment_submit')
        button.attr('disabled', 'disabled')
        button.html('Загрузка...')

        report = @get('report')
        current_user = @get('current_user')

        comment_hash = {
          content: ''
          commentable_id: report.get('id')
          commentable_type: 'Report'
          user_id: ''
        }

        if @get('comment_content')
          comment_hash.content = @get('comment_content')

        if current_user?
          comment_hash.user_id = current_user.id

        store = @get('store')
        comment = store.createRecord('comment', comment_hash)

        comment.save().then =>
          toastr.success('', 'Комментарий добавлен')
          comment.set('is_new', true)
          @pushObject(comment)
          @set('comment_content', '')
        , (reason) ->
          errors = reason.responseJSON
          message = ""

          if errors['content']?
            message = errors['content'].join(', ')

          toastr.error(message, 'Возникла ошибка при добавлении комментария')

        button.removeAttr('disabled', '')
        button.html('Отправить')