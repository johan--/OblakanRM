# for more details see: http://emberjs.com/guides/views/

OblakanRM.CommentsView = Ember.View.extend
  templateName: 'comments/comments'

  didInsertElement : ->
    $('form textarea').keydown (e) =>
      if ((e.ctrlKey || e.metaKey) && e.keyCode == 13)
        @get('controller').send('comment_submit')
        return false