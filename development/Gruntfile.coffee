module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-neuter'
  grunt.loadNpmTasks 'grunt-contrib-handlebars'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['handlebars:compile', 'neuter', 'compass:development', 'coffee:test', 'jasmine:test', 'clean', 'watch']
  grunt.registerTask 'build', ['handlebars:compile', 'neuter', 'uglify', 'compass:production']

  grunt.initConfig {
    watch:
      sass:
        files: ['sass/**/*.sass', 'sass/**/*.scss']
        tasks: ['compass:development']
      js:
        files: ['js/**/*.js']
        tasks: ['neuter', 'jasmine:test', 'clean']
      hbs:
        files: ['js/**/*.hbs']
        tasks: ['handlebars:compile', 'neuter', 'jasmine:test', 'clean']
      spec:
        files: ['spec/**/*.coffee']
        tasks: ['coffee:test', 'jasmine:test', 'clean']

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
          '_spec/specs.js': 'spec/**/*Spec.coffee'
          '_spec/helpers.js': 'spec/**/*Helper.coffee'

    clean: ['_spec']

    jasmine:
      test:
        src: '../public/js/application.js'
        options:
          specs: '_spec/specs.js'
          helpers: '_spec/helpers.js'

    handlebars:
      compile:
        options:
          namespace: 'App.JST'
          processName: (filename) ->
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
