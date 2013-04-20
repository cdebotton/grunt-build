grunt-build
===========

The basic settings for a JavaScript application build to by [Christian de Botton](mailto:debotton@brooklynunited.com).

### requirements
- `node.js` `>= 0.8.0`
- `npm` `>= 1.2.0`
- `ruby` `>= 1.8.7`
- `sass` `>= 3.2.7`
- `compass` `>= 0.12.0`
- `grunt-cli` `>= 0.1.6`

### features
- JavaScript concatenation using `grunt-neuter`.
- Minification using `grunt-contrib-uglify`.
- Automatic precompiling of Handlebars templates using `grunt-contrib-handlebars`.
- Automatic precompiling of SASS/SCSS files using `grunt-contrib-compass`.
- Jasmine tests, written in CoffeeScript, automatically tested whenever a Script, JST, Spec, or Helper is changed.

### in the future
- JSHinting of src files.
- LiveReload integration.

### getting started
First, clone this repository with `git clone -b master -o grunt-build git@github.com:cdebotton/grunt-build.git`.

Ones that's done, cd into the directory and run the following commands:

> `npm install` `bower install`

And that's it, you can start using the build tools.

To run the default watch tool that concatenates, runs tests, and compiles sass, simply type `grunt` from the `development` directory.

When ready to deploy the script, you can run `grunt build`, and it will minify the code.
