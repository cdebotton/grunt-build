describe('There is an application', function() {
  it('It has a router', function() {
    expect(App.Router).toBeTruthy();
  });

  it('It has a model', function() {
    expect(App.Model).toBeTruthy();
  });
});
