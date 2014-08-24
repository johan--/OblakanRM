# For more information see: http://emberjs.com/guides/routing/

OblakanRM.UserRoute = Ember.Route.extend
  model: (params) ->
    store = @get('store')
    user = store.find('user', params.user_id)
    store.findQuery('user').then (u) ->
      console.log("Found " + u.get('length') + " people named Peter.")
      console.log u.get('id')
    return user