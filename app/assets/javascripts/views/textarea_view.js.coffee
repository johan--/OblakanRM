OblakanRM.TextAreaView = Ember.TextArea.extend
  didInsertElement: ->
    ta = $(@$()).autosize()

Ember.Handlebars.helper('c-textarea', OblakanRM.TextAreaView)