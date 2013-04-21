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

  grunt.registerTask 'default', ['handlebars:compile', 'neuter', 'compass:development', 'coffee:test', 'mocha:test', 'clean', 'watch']
  grunt.registerTask 'build', ['handlebars:compile', 'neuter', 'uglify', 'compass:production']

  grunt.initConfig {
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
          cssDir: '../public/css/'
          environment: 'development'
      production:
        options:
          sassDir: './sass'
          cssDir: '../public/css/'
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
          namespace: 'App.JST'
          processName: (filename) ->
            if (matches = filename.match /([A-Za-z0-9\._-]+)\/templates\/([A-Za-z0-9\._-]+)\.hbs$/)
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
      './../public/js/application.js': './js/main.js'

    uglify:
      build:
        options:
          mangle: true
          preserveComments: false
          report: 'gzip'
        files:
          './../public/js/build.js': ['./../public/js/application.js']
  }
