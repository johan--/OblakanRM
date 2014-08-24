Ember.Handlebars.helper 't', (value, count, context) ->
  options = {}

  options.count = count if typeof count isnt 'object'
  options.context = context if typeof context isnt 'object'

  i18n.t(value, options)