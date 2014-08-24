# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.Subscriber = DS.Model.extend
  user: DS.belongsTo 'user'
  user_id: DS.attr 'number'
  subscribe_type: DS.attr 'string'
  subscribe_id: DS.attr 'number'