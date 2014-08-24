# For more information see: http://emberjs.com/guides/routing/

OblakanRM.AboutCallRoute = Ember.Route.extend
  activate: ->
    document.title = "ЕДДС — #{OblakanRM.settings.title}"