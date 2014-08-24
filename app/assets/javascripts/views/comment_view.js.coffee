# for more details see: http://emberjs.com/guides/views/

OblakanRM.CommentView = Ember.View.extend
  templateName: 'comments/comment'
  tagName: 'li'
  classNames: ['media', 'action']
  classNameBindings: ['is_new', 'is_deleted']

  is_new: (->
    @get('controller.model.is_new')
  ).property()

  is_deleted: (->
    @get('controller.model.is_deleted')
  ).property()

  didDeleted: (->
    @set('is_deleted', @get('controller.model.is_deleted'))
  ).observes('controller.model.is_deleted')

  didInsertElement : ->
    el = $(@.$())

    if el.hasClass('is-new')
      el.css('display', 'none').slideDown('fast')