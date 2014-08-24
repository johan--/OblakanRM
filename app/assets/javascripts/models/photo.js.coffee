# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.Photo = DS.Model.extend
  uid: DS.attr 'string'
  big_thumb: DS.attr 'string'
  medium_thumb: DS.attr 'string'
  small_thumb: DS.attr 'string'
  original_url: DS.attr 'string'
  created_at: DS.attr 'date'
  is_new: DS.attr 'boolean'
  entity_id: DS.attr 'number'
  entity_type: DS.attr 'string'