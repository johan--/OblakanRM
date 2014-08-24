# For more information see: http://emberjs.com/guides/routing/

OblakanRM.UnsubscribeRoute = Ember.Route.extend
  email: ''
  code: ''

  setupController: (controller, model) ->
    controller.set('email', @get('email'))
    controller.set('code', @get('code'))
    controller.set('model', model)

  model: (params) ->
    @set('email', params.email)
    @set('code', params.code)
    @store.find('user', { email: params.email }).then (users) =>
      if users.get('length') > 0
        user = users.objectAt(0)
        @store.find('subscriber', { user_id: user.get('id'), code: params.code }).then (subscribers) =>
          return subscribers.objectAt(0)