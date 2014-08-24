# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.Report = DS.Model.extend
  title: DS.attr 'string'
  description: DS.attr 'string'
  user: DS.belongsTo 'user'
  user_id: DS.attr 'number'
  latitude: DS.attr 'number'
  longitude: DS.attr 'number'
  address: DS.attr 'string'
  created_at: DS.attr 'date'
  start_photo: DS.belongsTo 'photo'
  start_photo_id: DS.attr 'number'
  photos_count: DS.attr 'number'
  comments_count: DS.attr 'number'
  photos: DS.hasMany 'photo', { async: true }
  comments: DS.hasMany 'comment', { async: true }
  subscribers: DS.hasMany 'subscriber', { async: true }
  subscribers_count: DS.attr 'number'
  near: DS.hasMany 'report', { async: true }
  status: DS.belongsTo 'status', { async: true }
  status_id: DS.attr 'number'
  category: DS.belongsTo 'category', { async: true }
  category_id: DS.attr 'number'
  is_deleted: DS.attr 'boolean'
  is_subscribed: DS.attr 'boolean'

  short_address: (->
    address = @get('address')
    if address?
      address.split(',').slice(2).join(', ')
  ).property('address')
