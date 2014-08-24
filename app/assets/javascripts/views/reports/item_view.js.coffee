# for more details see: http://emberjs.com/guides/views/

OblakanRM.ReportsItemView = Ember.View.extend
  templateName: 'reports/item'
  tagName: 'li'
  attributeBindings: ['dataId:data-id']

  dataId: (->
    @get('controller.model.id')
  ).property('data-id')

  didInsertElement: ->
    el = $(@.$()).find('time')
    if el
      date = moment(@get('controller.model.created_at'))
      el.attr('timedate', date.format())
      el.text(date.calendar()) if date

    category = null
    status = null
    markerColor = 'lightgray'
    model = @get('controller.model')
    store = @get('controller.store')

    faBugEl = $(@.$()).find('i.fa.status')
    if faBugEl.length > 0
      store.find('status', @get('controller.model.status_id')).then (st) ->
        status = st
        faBugEl.addClass(st.get('name'))
      category_id = parseInt(@get('controller.model.category_id'))
      if category_id > 0
        store.find('category', category_id).then (cat) ->
          category = cat
          faBugEl.addClass("fa-#{cat.get('icon')}")
      else
        faBugEl.addClass("fa-circle")

    $(@.$()).on 'mouseenter', =>
      if status
        statusName = status.get('name')
        if statusName == 'fixed'
          markerColor = 'green'
        else if statusName == 'rejected'
          markerColor = 'orange'
        else if statusName == 'confirmed'
          markerColor = 'blue'

      if category
        icon = category.get('icon')
      else
        icon = 'fa-circle'
      markerIcon = L.AwesomeMarkers.icon({
        icon: icon
        prefix: 'fa'
        markerColor: markerColor
      })
      map = window.OblakanRM.current_map
      lanLng = [@get('controller.model.latitude'), @get('controller.model.longitude')]
      if window.OblakanRM.current_marker
        map.removeLayer(window.OblakanRM.current_marker)
      marker = L.marker(lanLng, { icon: markerIcon })
      marker.addTo(map)
      address = @get('controller.model.short_address')
      if address
        marker.bindPopup(address).openPopup()
      window.OblakanRM.current_marker = marker
      map.setView(lanLng, map.getZoom())