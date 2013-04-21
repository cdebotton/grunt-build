describe 'The application', ->
  it 'has a router', ->
    App.PkgA.Router.should.be.a 'function'

  it 'has a model', ->
    App.PkgA.Model.should.be.a 'function'

  it 'has a view', ->
    App.PkgA.View.should.be.a 'function'
