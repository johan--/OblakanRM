# Handlebars Helpers - Dan Harper (http://github.com/danharper)

Ember.Handlebars.helper 'nl2br', (value) ->
  text = Handlebars.Utils.escapeExpression(value)
  nl2br = (text + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + '<br>' + '$2')
  return new Handlebars.SafeString(nl2br)
