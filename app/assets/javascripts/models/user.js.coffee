# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.User = DS.Model.extend
  created_at: DS.attr 'date'
  reports: DS.hasMany 'report'
  username: DS.attr 'string'
  email: DS.attr 'string'
  avatar: DS.attr 'string'
  is_admin: DS.attr 'boolean'
  is_staff: DS.attr 'boolean'
  is_male: DS.attr 'boolean'