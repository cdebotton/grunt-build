require('./js/pkgA/routers/app_router');
require('./js/pkgA/models/app_model');
require('./js/pkgA/views/app_view');

new App.PkgA.Router;
new App.PkgA.View({
  model: new App.PkgA.Model
});
