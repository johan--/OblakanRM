# for more details see: http://emberjs.com/guides/models/defining-models/

OblakanRM.CommentAttachment = DS.Model.extend
  photo: DS.belongsTo 'OblakanRM.Photo'
  comment: DS.belongsTo 'OblakanRM.Comment'
