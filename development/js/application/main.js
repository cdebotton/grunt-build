require('./js/application/routers/app_router');
require('./js/application/models/app_model');
require('./js/application/views/app_view');

var application   = new App.Router,
    View          = new App.View({
                          model: new App.Model
                        });
