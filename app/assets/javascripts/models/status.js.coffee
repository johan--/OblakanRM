# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.Status = DS.Model.extend
  name: DS.attr 'string'
  is_final: DS.attr 'boolean'
  reports: DS.hasMany 'report', { async: true }

  nameTranslate: (->
    i18n.t("report.#{@get('name')}")
  ).property('name')