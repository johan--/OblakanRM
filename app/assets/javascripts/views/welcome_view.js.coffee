OblakanRM.WelcomeView = Ember.View.extend
  tagName: 'div'
  classNames: ['welcome']

  didInsertElement : ->
    if localStorage.getItem('first_visit') == 'true' && !@get('controller.wasShow')
      $(@.$()).fadeIn(0.3)
      @set('controller.wasShow', true)