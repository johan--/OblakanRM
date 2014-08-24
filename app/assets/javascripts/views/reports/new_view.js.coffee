OblakanRM.ReportsNewView = Ember.View.extend
  didChangedCategory: (->
    icon = @get('controller.selectedCategory.icon')
    if icon && window.OblakanRM.current_marker
      markerIcon = L.AwesomeMarkers.icon({
        icon: icon
        prefix: 'fa'
        markerColor: 'lightgray'
      })
      window.OblakanRM.current_marker.setIcon(markerIcon)
  ).observes('controller.selectedCategory')

  didInsertElement: ->
    if (!(FileAPI.support.cors || FileAPI.support.flash))
      alert 'ERROR WITH INITIALIZING'

    height = $('form').height();
    $('#short_map').css('height', height + 'px')
    $('#short_map').css('width', '500px')
    map = L.map('short_map', {
      center: [53.717, 91.43],
      zoom: 13,
      minZoom: 12
    })
    OblakanRM.settings.get_tile_layer().addTo(map)

    lat = 53.717
    lng = 91.43

    OblakanRM.current_form.latitude = lat
    OblakanRM.current_form.longitude = lng

    markerIcon = L.AwesomeMarkers.icon({
      icon: 'circle'
      prefix: 'fa'
      markerColor: 'lightgray'
    })

    marker = L.marker([lat, lng], {draggable: true, icon: markerIcon}).addTo(map)
    marker.bindPopup("Меня можно перетаскивать").openPopup()
    window.OblakanRM.current_marker = marker

    marker.on 'dragend', (event) ->
      target = event.target
      result = target.getLatLng()
      OblakanRM.current_form.latitude = result.lat
      OblakanRM.current_form.longitude = result.lng