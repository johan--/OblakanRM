L.Control.CityLabel = L.Control.extend
  options: {
    position: 'topright'
    city: ''
    edds: '000'
    disabled: false
    stats:
      all: 0
      users: 0
      opened: 0
      closed: 0
    classes: 'leaflet-control-report-city-label'
  }

  initialize: (options) ->
    L.setOptions(this, options)

  onAdd: (map) ->
    @_container = L.DomUtil.create('div', @options.classes)
    @_container.innerHTML = "<h3>#{@options.city}</h3>
    <div class=\"edds\">Единая диспетчерская служба — <i class=\"fa fa-phone\"></i> #{@options.edds}</div>
    <div class=\"stats\">
    <h4>Статистика проблем</h4>

    <div>Всего: <span class=\"all\">#{@options.stats.all}</span></div>
    <div>Открытых: <span class=\"opened\">#{@options.stats.opened}</span></div>
    <div>Закрытых: <span class=\"closed\">#{@options.stats.closed}</span></div>
    <div>Сообщили: <span class=\"users\">#{@options.stats.users} человек</span></div>
    </div>"
    L.DomEvent.disableClickPropagation(@_container)
    @_updateState()
    @_update()
    @_container

  _updateState: ->
    if @options.disabled
      $(@_container).slideUp()
    else
      $(@_container).slideDown()
      $(@_container).find('h3').html(@options.city)
      $(@_container).find('span.all').html(@options.stats.all)
      $(@_container).find('span.opened').html(@options.stats.opened)
      $(@_container).find('span.closed').html(@options.stats.closed)
      $(@_container).find('span.users').html(i18n.t('human', {count: @options.stats.users}))

  enable: (state, options = {}) ->
    if options
      @options = $.extend({}, @options, options)
    @options.disabled = !state
    @_updateState()
    @_update()

  _update: ->
    unless @_map
      return

L.control.citylabel = (options) ->
  return new L.Control.CityLabel(options)