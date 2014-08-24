# for more details see: http://emberjs.com/guides/controllers/

OblakanRM.WelcomeController = Ember.Controller.extend
  wasShow: false

  actions:
    close: ->
      $('.welcome').fadeOut(0.3)
      @set('wasShow', true)