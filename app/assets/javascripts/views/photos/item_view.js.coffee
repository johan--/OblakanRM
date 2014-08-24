# for more details see: http://emberjs.com/guides/views/

OblakanRM.PhotosItemView = Ember.View.extend
  tagName: 'li'
  classNameBindings: ['is_new']

  is_new: (->
    @get('controller.model.is_new')
  ).property()

  is_deleted: (->
    $(@.$()).remove()
  ).observes('controller.model.isDeleted')