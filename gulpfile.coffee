gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'

bundle = (name) ->
  browserify({
    cache: {}, packageCache: {}, fullPaths: true, # watchify
    entries: ["./src/#{name}.coffee"]
    extensions: ['.coffee']
    debug: true # source maps
  })
    .bundle()
    .pipe(source("#{name}.js"))
    .pipe(gulp.dest('./web/'));

gulp.task 'main', -> bundle('main')
gulp.task 'test', -> bundle('test')

gulp.task('default', ['main', 'test']);
