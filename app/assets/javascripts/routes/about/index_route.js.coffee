# For more information see: http://emberjs.com/guides/routing/

OblakanRM.AboutIndexRoute = Ember.Route.extend
  activate: ->
    document.title = "О проекте — #{OblakanRM.settings.title}"