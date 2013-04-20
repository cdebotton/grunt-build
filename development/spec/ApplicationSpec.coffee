describe 'There is an application', ->
  it 'has a router', ->
    App.Router.should.be.a 'function'

  it 'has a model', ->
    App.Model.should.be.a 'function'

  it 'has a view', ->
    App.View.should.be.a 'function'
