# for more details see: http://emberjs.com/guides/views/

OblakanRM.ReportsPopupItemView = Ember.View.extend
  templateName: 'reports/item'
  tagName: 'div'
  classBindings: ['cpopup']
  attributeBindings: ['dataId:data-id']
  model: Ember.computed.alias("controller.model")

  dataId: (->
    @get('model.id')
  ).property('data-id')

  didInsertElement: ->
    store = @get('controller.store')
    model = @get('model')
    el = $(@.$()).find('time')
    if el
      date = moment(@get('model.created_at'))
      el.attr('timedate', date.format())
      el.text(date.calendar()) if date

    Ember.RSVP.all(
      [
        category_id = parseInt(model.get('category_id'))
        if category_id > 0
          store.find('category', model.get('category_id')).then (category) ->
            model.set('category', category)

        store.find('status', model.get('status_id')).then (status) ->
          model.set('status', status)

        start_photo_id = parseInt(model.get('start_photo_id'))
        if start_photo_id > 0
          store.find('photo', model.get('start_photo_id')).then (photo) ->
            model.set('start_photo', photo)
      ]
    ).then =>
      faBugEl = $(@.$()).find('i.fa.status')
      statusName = @get('model.status.name')
      if statusName == 'fixed'
        markerColor = 'green'
      else if statusName == 'rejected'
        markerColor = 'orange'
      else if statusName == 'confirmed'
        markerColor = 'blue'
      else
        markerColor = 'lightgray'

      if model.get('category')
        icon = model.get('category.icon')
      else
        icon = 'fa-circle'

      if faBugEl
        faBugEl.addClass(statusName)
        faBugEl.addClass("fa-#{icon}")

      popup = L.popup({ minWidth: 500 }).setContent("<div class=\"cpopup\">#{$(@.$()).html()}</div>")

      markerIcon = L.AwesomeMarkers.icon({
        icon: icon
        prefix: 'fa'
        markerColor: markerColor
      })

      marker = new MyCustomMarker([@get('model.latitude'), @get('model.longitude')], icon: markerIcon)
      marker.bindPopup(popup, { showOnMouseOver: true })
      marker.on 'click', =>
        @get('controller').transitionToRoute('report', @get('model.id'))
      OblakanRM.current_markers.addLayer(marker)