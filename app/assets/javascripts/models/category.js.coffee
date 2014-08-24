# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.Category = DS.Model.extend
  title: DS.attr 'string'
  description: DS.attr 'string'
  icon: DS.attr 'string'
  parentId: DS.attr 'number'
  reports: DS.hasMany 'report', { async: true }
