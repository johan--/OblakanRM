OblakanRM.ReportsSubscriptionView = Ember.View.extend
  parentSelector: ''
  contentSelector: ''
  didInsertElement: ->
    self = @
    $(self.parentSelector).popover
      html: true,
      title: self.title,
      placement: 'top',
      content: ->
        $content = $(self.contentSelector)
        return $content.html()

    $(self.parentSelector).click =>
      $(@).toggleClass('active')

  close: ->
    $(@.parentSelector).popover('hide')