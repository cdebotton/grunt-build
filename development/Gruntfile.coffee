Config = {
  APP_NAME: 'App'
  BUILD_DIR: '../public'
  CSS_DEST: 'styles.css'
  CONCAT_DEST: 'application.js'
  BUILD_DEST: 'build.js'
  TEST: true
}

module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-neuter'
  grunt.loadNpmTasks 'grunt-contrib-handlebars'
  grunt.loadNpmTasks 'grunt-mocha'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  defaultTasks = ['handlebars:compile', 'neuter', 'compass:development', 'coffee:test', 'mocha:test', 'clean', 'watch']
  buildTasks = ['handlebars:compile', 'neuter', 'uglify', 'compass:production']

  configObject = {
    watch:
      sass:
        files: ['sass/**/*.sass', 'sass/**/*.scss']
        tasks: ['compass:development']
      js:
        files: ['js/**/*.js']
        tasks: ['neuter', 'mocha:test', 'clean']
      hbs:
        files: ['js/**/*.hbs']
        tasks: ['handlebars:compile', 'neuter', 'mocha:test', 'clean']
      spec:
        files: ['specs/**/*Spec.coffee']
        tasks: ['coffee:test', 'mocha:test', 'clean']

    compass:
      development:
        options:
          sassDir: './sass'
          cssDir: "#{Config.BUILD_DIR}/css"
          environment: 'development'
      production:
        options:
          sassDir: './sass'
          cssDir: "#{Config.BUILD_DIR}/css"
          environment: 'production'

    jshint:
      all: ['js/**/*.js']
      options:
        jshintrc: '.jshintrc'

    coffee:
      test:
        files:
          '_spec/specs.js': 'specs/**/*Spec.coffee'

    clean: ['_spec']

    mocha:
      test:
        src: ['./specs/SpecRunner.html']
        options:
          mocha:
            ignoreLeaks: false
          reporter: 'Spec'
          ui: 'bdd'
          run: true

    handlebars:
      compile:
        options:
          namespace: "#{Config.APP_NAME}.JST"
          processName: (filename) ->
            if (matches = filename.match /js\/([A-Za-z0-9\._-]+)\/templates\/([A-Za-z0-9\._-]+)\.hbs$/)
              className = matches[1][0].toUpperCase() + matches[1][1..-1]
              tplName = matches[2]
              return "#{className}.#{tplName}"
            else
              parts = filename.split('/')
              len = parts.length
              return parts[len-1].match(/(.+)\.hbs$/)[1]
        files:
          './js/hbs.js': ['./js/**/*.hbs']

    neuter:
      options:
        includeSourceURL: false

    uglify:
      build:
        options:
          mangle: true
          preserveComments: false
          report: 'gzip'
        files: {}
  }

  configObject.neuter["#{Config.BUILD_DIR}/js/#{Config.CONCAT_DEST}"] = './js/main.js'
  configObject.uglify.build.files["#{Config.BUILD_DIR}/js/#{Config.BUILD_DEST}"] = "#{Config.BUILD_DIR}/js/#{Config.CONCAT_DEST}"

  if not Config.TEST
    delete configObject.mocha
    delete configObject.watch.spec

    if ((index = defaultTasks.indexOf('mocha:test')) > -1)
      defaultTasks.splice index, 1

    if ((index = defaultTasks.indexOf('coffee:test')) > -1)
      defaultTasks.splice index, 1

    if ((index = defaultTasks.indexOf('clean')) > -1)
      defaultTasks.splice index, 1

    if ((index = configObject.watch.hbs.tasks.indexOf('mocha:test')) > -1)
      configObject.watch.hbs.tasks.splice index, 1

    if ((index = configObject.watch.hbs.tasks.indexOf('clean')) > -1)
      configObject.watch.hbs.tasks.splice index, 1

    if ((index = configObject.watch.js.tasks.indexOf('mocha:test')) > -1)
      configObject.watch.js.tasks.splice index, 1

    if ((index = configObject.watch.js.tasks.indexOf('clean')) > -1)
      configObject.watch.js.tasks.splice index, 1

  grunt.registerTask 'default', defaultTasks
  grunt.registerTask 'build', buildTasks

  grunt.initConfig configObject
