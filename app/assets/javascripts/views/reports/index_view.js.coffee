OblakanRM.ReportsIndexView = Ember.View.extend
  didInsertElement: ->
    $('input[type="radio"]:checked').parent('label').addClass('active')
    self = @
    $('input[name="view"]').on 'change', ->
      self.set('controller.isSelected', $(@).val())