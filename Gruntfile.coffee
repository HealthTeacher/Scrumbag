BUILD_DIR = './_build'
APP_DIR = './app'
path = require('path')

module.exports = (grunt) ->

  grunt.initConfig
    secret: grunt.file.readJSON('secret.json')

    coffee:
      glob_to_multiple:
        expand: true
        flatten: false
        cwd: 'src/js'
        src: ['**/*.coffee']
        dest: 'app/js/'
        ext: '.js'
        bare: true

    jshint:
      all: ['./app/js/*.js']
      options:
        force: true
        reporter: require('jshint-stylish')
        ignores: ['./app/js/require.js']

    requirejs:
      compile:
        options:
          mainConfigFile: "app/js/config.js",
          baseUrl: './app/js'
          optimize: 'uglify'
          name: "main"
          out: '_build/js/main.js'

    watch:
      js:
        files: ['./src/js/**/*']
        tasks: ["coffee", "bower"]
        options:
          reload: true
          spawn: false
      sass:
        files: [
          './src/css/**/*'
        ]
        tasks: ["sass"]
        options:
          reload: true
          spawn: false
      indexTemplate:
        files: ['./src/index.html']
        tasks: ["copy:htmlToApp"]
        options:
          reload: true
          spawn: false
      templates:
        files: ['./src/templates/**/*']
        tasks: ["copy:templatesToApp"]
        options:
          reload: true
          spawn: false

    bower:
      all:
        rjsConfig: 'app/js/config.js'
        options:
          baseUrl: './'
          transitive: true

    copy:
      libToApp:
        expand: true
        src: [
          './lib/**/*.js',
          './lib/**/*.map'
        ]
        dest: path.join(APP_DIR, 'js')
      htmlToApp:
        expand: true
        flatten: true
        src: './src/index.html'
        dest: './app'
      templatesToApp:
        expand: true
        flatten: false
        cwd: "./src/templates"
        src: '**/*'
        dest: './app/js/templates'
      requirejs:
        expand: true
        flatten: false
        src: ['./lib/requirejs/require.js']
        dest: path.join(BUILD_DIR, 'js')
      config:
        expand: true
        flatten: true
        src: ['./app/js/config.js']
        dest: path.join(BUILD_DIR, 'js')
      indexTemplate:
        expand: true
        flatten: true
        src: './app/index.html'
        dest: BUILD_DIR
      templates:
        expand: true
        flatten: false
        cwd: "./app/templates"
        src: '**/*'
        dest: BUILD_DIR + "/js/templates"
      styles:
        expand: true
        flatten: true
        src: './app/css/**/*'
        dest: path.join(BUILD_DIR, 'css')

    sass:
      dist:
        files: [{
          expand: true
          cwd: 'src/css'
          src: ['*.scss']
          dest: 'app/css/'
          ext: '.css'
        }]

    rsync:
      options:
        args: ['--verbose']
        recursive: true
      production:
        options:
          src: './_build/*'
          dest: '<%= secret.deploy.production.deploy_path %>'
          host: '<%= secret.deploy.production.username%>@<%= secret.deploy.production.host %>',
          delete: true # be careful with this! Double-check your deploy path!

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-bower-requirejs')
  grunt.loadNpmTasks('grunt-contrib-requirejs')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-sass')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-rsync')

  grunt.registerTask "copyApp", [
    "copy:libToApp"
    "copy:htmlToApp"
    "copy:templatesToApp"
  ]

  grunt.registerTask "copyBuild", [
    "copy:requirejs"
    "copy:config"
    "copy:indexTemplate"
    "copy:templates"
    "copy:styles"
  ]

  grunt.registerTask('build', [
    'coffee'
    'sass'
    'copyApp'
    'bower'
    'jshint'
    'requirejs'
    'copyBuild'
  ])

  grunt.registerTask('deploy', ['build', 'rsync'])
