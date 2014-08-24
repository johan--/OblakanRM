# For more information see: http://emberjs.com/guides/routing/

OblakanRM.ReportsIndexRoute = Ember.Route.extend
  activate: ->
    document.title = "Проблемы — #{OblakanRM.settings.title}"
    $('meta[name=description]').attr('content', 'Список проблем')

  model: ->
    @store.find 'report'