# For more information see: http://emberjs.com/guides/routing/

OblakanRM.Router.reopen
  location: 'history'

OblakanRM.Router.map ()->
  @route 'index', { path: '/' }
  @resource 'about', ->
    @route 'call'
  @route 'rules', { path: '/rules' }
  @route 'works', { path: '/how-it-works' }
  @route 'open-data', { path: '/open-data' }
  @resource 'reports', ->
    @route 'map'
    @route 'new'
  @route 'report', { path: '/reports/:report_id' }
  @route 'user', { path: '/user/:user_id' }
  @route 'notFound', { path: '/errors/404' }
  @route 'unsubscribe', { path: '/unsubscribe/:email/:code' }
  @route 'undefinedError', { path: '/errors/000' }