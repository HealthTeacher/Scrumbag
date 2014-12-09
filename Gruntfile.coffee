module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    watch:
      scripts:
        files: "**/*.coffee"
        tasks: 'coffee'
      styles:
        files: "**/*.scss"
        tasks: 'sass'

    coffee:
      glob_to_multiple:
        expand: true
        flatten: false
        cwd: 'app/scripts'
        src: ['**/*.coffee']
        dest: 'public/js/'
        ext: '.js'
        bare: true

    sass:
      dist: {
        files: [{
          expand: true,
          cwd: 'app/styles',
          src: ['*.scss'],
          dest: 'public/css/',
          ext: '.css'
        }]
      }

  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-sass');

  grunt.registerTask('default', ['coffee'])
