OblakanRM.ReportView = Ember.View.extend
  model: Ember.computed.alias("controller.model")

  didModelChanged: (->
    content = title = @get('controller.model.title')
    description = @get('controller.model.description')
    address = @get('controller.model.short_address')
    $(document).attr('title', "#{title} — #{OblakanRM.settings.title}")

    if description
      if description.length > 255
        description = description.truncateOnWord(255)
      content = description
    else if (address)
      content = address

    $('meta[name=description]').attr('content', content)

    marker = window.OblakanRM.current_marker

    if marker && window.OblakanRM.current_map
      lanLng = [@get('controller.model.latitude'), @get('controller.model.longitude')]

      marker.setLatLng(lanLng)
      map = window.OblakanRM.current_map
      map.setView(lanLng, map.getZoom())
  ).observes('controller.model.title')

  didStatusChanged: (->
    marker = window.OblakanRM.current_marker
    hash = window.OblakanRM.current_marker_icon_hash

    if marker && hash
      statusName = @get('controller.model.status.name')
      markerColor = 'lightgray'

      if statusName == 'fixed'
        markerColor = 'green'
      else if statusName == 'rejected'
        markerColor = 'orange'
      else if statusName == 'confirmed'
        markerColor = 'blue'

      hash = window.OblakanRM.current_marker_icon_hash
      hash.markerColor = markerColor
      window.OblakanRM.current_marker_icon_hash = hash

      markerIcon = L.AwesomeMarkers.icon(hash)
      marker.setIcon(markerIcon)
  ).observes('controller.model.status')

  didChangedCategory: (->
    marker = window.OblakanRM.current_marker
    hash = window.OblakanRM.current_marker_icon_hash

    if marker && hash
      icon = 'fa-circle'

      if @get('controller.model.category')
        icon = @get('controller.model.category.icon')

      hash.icon = icon
      window.OblakanRM.current_marker_icon_hash = hash

      markerIcon = L.AwesomeMarkers.icon(hash)
      window.OblakanRM.current_marker.setIcon(markerIcon)
  ).observes('controller.model.category')

  didStartPhotoChanged: (->
    start_photo = @get('controller.model.start_photo')
    vk_options = {
      url: window.location
      title: document.title
      description: $('dd.address').text()
    }
    if start_photo
      vk_options.image = start_photo.get('medium_thumb')
    else
      delete vk_options['image']
    $('#vk_share').html(VK.Share.button(vk_options, {type: 'custom', text: '<img src="http://vk.com/images/vk32.png" />'}))
  ).observes('controller.model.start_photo')

  didInsertElement: ->
    model = @get('model')
    @didStartPhotoChanged()

    $('#twitter_share a').attr('data-url', window.location)
    $('#twitter_share a').attr('data-text', $('div.report h3.panel-title').text() + " | " + $('dd.address').text())
    $('#facebook_share a').attr('href', "https://www.facebook.com/sharer/sharer.php?u=#{window.location}")

    time = $(@.$()).find('.meta time')
    date = moment(time.attr('datetime'))
    time.text(date.format('LLL')) if date

    position = [model.get('latitude'), model.get('longitude')]
    map = L.map('short_map', {
      center: position,
      zoom: 16
      minZoom: 14
      editInOSMControlOptions: {
        widget: 'attributionBox'
        position: 'bottomleft'
        editors: ['id']
      }
    })
    OblakanRM.settings.get_tile_layer().addTo(map)

    icon = 'fa-circle'
    statusName = model.get('status.name')
    markerColor = 'lightgray'

    if statusName == 'fixed'
      markerColor = 'green'
    else if statusName == 'rejected'
      markerColor = 'orange'
    else if statusName == 'confirmed'
      markerColor = 'blue'

    if model.get('category')
      icon = model.get('category.icon')

    markerIconHash = {
      icon: icon
      prefix: 'fa'
      markerColor: markerColor
    }
    markerIcon = L.AwesomeMarkers.icon(markerIconHash)

    marker = L.marker(position, { icon: markerIcon })
    window.OblakanRM.current_marker_icon_hash = markerIconHash
    window.OblakanRM.current_marker = marker
    window.OblakanRM.current_map = map
    marker.addTo(map)

    marker.on 'dragend', (event) ->
        target = event.target
        result = target.getLatLng()
        model.set('latitude', result.lat)
        model.set('longitude', result.lng)

    $('ul.nav.nav-tabs a').on 'click', (e) ->
      e.preventDefault()
      $(this).tab('show')

    $('body').on 'click', '#map_link', ->
      map.invalidateSize(false)

    $("[data-toggle='tooltip']").tooltip()

    @didModelChanged()