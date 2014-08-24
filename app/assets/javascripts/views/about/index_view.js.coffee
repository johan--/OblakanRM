OblakanRM.AboutIndexView = Ember.View.extend
  didInsertElement: ->
    $('meta[name=description]').attr('content', $('div.description').text().truncateOnWord(255))