
Ember.Handlebars.helper 'ago', (value, options) ->
  date = moment(value)
  date.fromNow()