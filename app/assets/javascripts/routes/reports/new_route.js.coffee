# For more information see: http://emberjs.com/guides/routing/

OblakanRM.ReportsNewRoute = Ember.Route.extend
  activate: ->
    document.title = "Сообщить о проблеме — #{OblakanRM.settings.title}"

  setupController: (controller) ->
    promises = [
      @store.find('category').then (categories) ->
        controller.set('categories', categories)
    ]
    return Ember.RSVP.all(promises)