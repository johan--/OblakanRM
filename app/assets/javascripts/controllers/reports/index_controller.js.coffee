OblakanRM.ReportsIndexController = Ember.ArrayController.extend
  sortProperties: ['created_at']
  sortAscending: false
  itemController: 'ReportsItem'
  currentPage: 1
  perPage: 10

  paginatedContent: (->
    currentPage = @get('currentPage')
    perPage = @get('perPage')
    end = currentPage * perPage
    @get('arrangedContent').slice(0, end)
  ).property('arrangedContent.[]', 'currentPage', 'perPage')

  canLoadMore: (->
    @get('currentPage') < @get('maxPage')
  ).property('arrangedContent.[]', 'currentPage')

  maxPage: (->
    @get('model').store.typeMapFor(@get('model').type).metadata.total_pages
  ).property()

  actions:
    loadMore: ->
      @store.find('report', { page: @incrementProperty('currentPage') })