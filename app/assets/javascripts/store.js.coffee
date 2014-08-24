# http://emberjs.com/guides/models/defining-a-store/

OblakanRM.Store = DS.Store.extend
  revision: 11
  adapter: OblakanRM.ApplicationAdapter

OblakanRM.ApplicationAdapter = DS.RESTAdapter.extend
  namespace: 'api'