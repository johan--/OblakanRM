# For more information see: http://emberjs.com/guides/routing/

OblakanRM.ReportRoute = Ember.Route.extend
  subscribers: []

  model: (params) ->
    @store.find 'report', params.report_id

  afterModel: (report) ->
    store = @get('store')

    start_photo_id = parseInt(report.get('start_photo_id'))
    category_id = parseInt(report.get('category_id'))

    promises = [
      if start_photo_id > 0
        store.find('photo', report.get('start_photo_id'))
      if category_id > 0
        store.find('category', report.get('category_id'))
      store.find('status', report.get('status_id'))
    ]

    return Ember.RSVP.all(promises)