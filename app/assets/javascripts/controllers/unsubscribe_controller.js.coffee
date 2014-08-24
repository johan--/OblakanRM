# for more details see: http://emberjs.com/guides/controllers/

OblakanRM.UnsubscribeController = Ember.Controller.extend
  email: ''
  code: ''

  isDone: false

  actions:
    redirectToMain: ->
      @transitionToRoute('index')

    unsubscribe: ->
      model = @get('model')

      $.ajax
          type: 'POST'
          url: "/api/subscribers/#{model.get('id')}?email=#{@get('email')}&code=#{@get('code')}"
          dataType: 'json'
          data: {'_method':'delete'},
          complete: =>
            @set('isDone', true)
            toastr.success('', 'Вы успешно отписались от событий')