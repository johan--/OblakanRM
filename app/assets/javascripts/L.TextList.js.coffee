L.Control.TextList = L.Control.extend
  options: {
    position: 'topleft'
    url: ''
    disabled: false
    classes: 'btn btn-sm btn-default leaflet-control-report-text-list'
  }

  initialize: (options) ->
    L.setOptions(this, options)

  onAdd: (map) ->
    @_container = L.DomUtil.create('a', @options.classes)
    @_container.href = @options.url
    @_container.title = 'Текстовый список'
    @_container.innerHTML = '<span class="fa fa-list"></span>'
    L.DomEvent.disableClickPropagation(@_container)
    @_updateState()
    @_update()
    @_container

  _updateState: ->
    if @options.disabled
      unless $(@_container).hasClass('leaflet-control-disabled')
        $(@_container).addClass('leaflet-control-disabled')
      @_container.title = 'Текстовый список недоступен в этой местности'
      @_container.onclick = (e) ->
        e.preventDefault()
    else
      $(@_container).removeClass('leaflet-control-disabled')
      @_container.onclick = null

  enable: (state) ->
    @options.disabled = !state
    @_updateState()
    @_update()

  _update: ->
    unless @_map
      return

L.control.textlist = (options) ->
  return new L.Control.TextList(options)