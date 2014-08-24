# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.Comment = DS.Model.extend
  content: DS.attr 'string'
  commentable_type: DS.attr 'string'
  commentable_id: DS.attr 'number'
  created_at: DS.attr 'date'
  user: DS.belongsTo 'user', {async: true}
  is_new: DS.attr 'boolean'
  is_deleted: DS.attr 'boolean'

  css_class: (->
    if @get('is_new') then 'new' else ''
  ).property('is_new')