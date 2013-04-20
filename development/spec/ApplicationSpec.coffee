describe 'There is an application', ->
  it 'has a router', ->
    expect(App.Router).toBeTruthy()

  it 'has a model', ->
    expect(App.Model).toBeTruthy()

  it 'has a view', ->
    expect(App.View).toBeTruthy()
