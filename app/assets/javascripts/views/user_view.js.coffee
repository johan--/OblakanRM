OblakanRM.UserView = Ember.View.extend
  didInsertElement: ->
    model = @get('controller').get('model')