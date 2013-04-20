module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-neuter'
  grunt.loadNpmTasks 'grunt-contrib-handlebars'

  grunt.registerTask 'default', ['handlebars:compile', 'neuter', 'compass:development', 'watch']
  grunt.registerTask 'build', ['handlebars:compile', 'neuter', 'uglify', 'compass:production']

  grunt.initConfig {
    watch:
      sass:
        files: ['sass/**/*.sass', 'sass/**/*.scss']
        tasks: ['compass:development']
      js:
        files: ['js/**/*.js']
        tasks: ['neuter']
      hbs:
        files: ['js/**/*.hbs']
        tasks: ['handlebars:compile', 'neuter']

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
      busby:
        options:
          mangle: true
          preserveComments: false
          report: 'gzip'
        files:
          './../public/js/build.js': ['./../public/js/application.js']
  }
