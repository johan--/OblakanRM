# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.Activity = DS.Model.extend
  created_at: DS.attr 'date'
  key: DS.attr 'string'