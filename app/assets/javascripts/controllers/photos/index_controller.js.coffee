# for more details see: http://emberjs.com/guides/controllers/

OblakanRM.PhotosIndexController = Ember.ArrayController.extend
  sortProperties: ['created_at']
  sortAscending: false
  itemController: 'PhotosItem'
  needs: ['report']
  report: Ember.computed.alias('controllers.report')
  current_user: OblakanRM.get_current_user()