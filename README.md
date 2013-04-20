# grunt build tool
by [Christian de Botton](cdebotton@gmail.com)

## about the thing

This build tool is meant to simplify development. It handles a lot of things for you so you don't have to worry about it, and you can just assume things will be set up correctly for you. It also eliminates the need for Require.js, which makes things like BDD and Dependency management much simpler. No more shims, *sick*.

## some important files

The project is split into two primary folders. `development/` and `public/`. Development is where you write all of your JavaScript, SASS/SCSS, Test Suites, Handlebars templates, etc. The build tool will then compile everything to `public/`. All JavaScript will be concatenated to `/public/js/application.js` and, when built, minified to `/public/js/build.js`. Your styles will go to `public/css/styles.css`. When developing, the CSS will have source-mapping enabled so CSS debugging in browser tracks back to the correct SASS files and lines. I'm going to try to add this to JavaScript in the future as well.

When Working in a framework, you're going to want to modify the build tool so that it compiles the front end build to the public facing directory within the framework.

Let's take a look at the development folder now, where are there some important files for getting started.

`/development/component.json`

> This contains all of the front end libraries you intend on using, the boilerplate file includes some that you will probably want to have. Feel free to remove or add anything you want, though it is **important** to note that if you remove `mocha`, `chai`, `sinon`, or `sinon-chai`, the test suite will break.

`/development/package.json`
> Includes the node dependencies for running the build tool. You shouldn't have to change anything here.

`/development/Gruntfile.coffee`
> Contains the configuration for the grunt tasks. You may need to change a setting in here if you want to modify where your files are compiling to or how the Handlebars templates are named (by default, they're the name of the file sans extension).

## installing

### requirements
- [`node.js`](http://nodejs.org) `>= 0.10.0`
- [`npm`](http://nodejs.org) `>= 1.2.0`
- `ruby` `>= 1.8.7` (Recommend using [`RVM`](https://rvm.io/) for Ruby management).
- `sass` `>= 3.2.7`(`sudo gem install sass`)
- `compass` `>= 0.12.0` (`sudo gem install compass`)
- `grunt-cli` `>= 0.1.6`(`sudo npm install -g grunt-cli`)

### setting up environment

To install the node modules, in the terminal at the project root, type the following:

> cd development

> npm install

If you get installation errors, you can either run `sudo npm install` or properly set the owner and permissions of the ~/.npm directory.

> sudo chown -R `your_user_name` ~/.npm

> sudo chmod -R 777 ~/.npm

Once the node modules are installed, you need to install the front end dependencies. Simply run:

> bower install

Again, if you get errors, you probably need to set permissions

> sudo chown -R `your_user_name` ~/.bower

> sudo chmod -R 777 ~/.bower

And that's it, you're ready to start using the build tool. Run `grunt` and it will begin watching your files for changes and continuously building your application. Alternative, if you run `grunt build`, it will generate the minified code and deliver it to the `public` folder.

## building your application

The way you structure your application will be slightly different from how you would with an `AMD` Library like [`require.js`](http://requirejs.org). Will need to call out our namespaces manually, which will help structure our application and allow us to more easily test our code. There is a file provided at `/development/js/ns.js` for writing these definitions, which may look something like this for a [`Backbone`](http://backbonejs.org/backbone.js) app:

```javascript
"use strict";

window.App = {};

App.Models = {};
App.Collections = {};
App.Views = {};
App.Routers = {};
App.Helpers = {};

```

With that out of the way, there are a few other files in the root of the `js` directory.

`libraries.js`
> Load in all of the front-end libraries you want to use. Because the application is working in the global name space, you won't have to require any of these libraries at any other point in the application.

`application/main.js`
> Where the application is instantiated.

When writing your code, if you need to require a dependency, you would just call `require('./js/folder/DEPENDENCY_NAME');`, and the build tool will know to load that script so it's available for that file. If you require the same file in multiple locations, it will find the earliest point that the dependency is needed and place it at that point.

A simple application instantiation may look like this:

`application/main.js`
```javascript
"use strict";

// Require compiled JST Templates file.
require('./js/hbs.js');

// Require the model.
require('./js/application/models/app_model');

// Require the view.
require('./js/application/views/app_view');


// Instantiate the application.
var app = new App.View({
  model: new App.Model
});
```

`application/models/app_model.js`
```javascript
"use strict";

// Define the model.
App.Model = Backbone.Model.extend({

  // Set defaults.
  defaults: {
    'title': 'My Application',
    'body': 'Lipsum...'
  }

});
```

`application/views/app_view.js`
```javascript
"use strict";

// Define the view.
App.View = Backbone.View.extend({

  // Set the root app element.
  el: '#application-root',

  // Use underscore binding to set context on callbacks.
  initialize: function() {
    _.bindAll(this);
  },

  // Render using the compiled JST template.
  render: function() {
    var ctx   = this.model.toJSON(),
      html  = App.JST['application'](ctx);

    this.$el.html(html);
    return this;
  }

});
```

`applcation/templates/application.hbs`
```html
  <h1>{{title}}</h1>
  <p>{{body}}</p>
```

The structure of the files within the `js/` directory can change, it's simply defined by how you manage your `require()` calls.
