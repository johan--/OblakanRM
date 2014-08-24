# For more information see: http://emberjs.com/guides/routing/

OblakanRM.IndexRoute = Ember.Route.extend
  activate: ->
    document.title = "#{OblakanRM.settings.title}"
    $('meta[name=description]').attr('content', 'Список проблем на карте')

  model: ->
    @store.find('report', { map_scope: true })

  afterModel: (reports) ->
    totalPages = reports.store.typeMapFor(reports.type).metadata.total_pages
    page = 2

    Ember.run.scheduleOnce 'afterRender', @, =>
      while page < totalPages
        @store.find('report', { map_scope: true, page: page }).then (records) ->
          records.forEach (record) ->
            reports.pushObject(record)
        page++