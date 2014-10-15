gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'

transpile = (name) ->
  browserify({
    entries: ['./src/main.coffee'],
    extensions: ['.coffee']
  })
    .bundle()
    .pipe(source('main.js'))
    .pipe(gulp.dest('./web/'));
 
gulp.task('browserify', ->
  transpile('main')
);

gulp.task('default', ['browserify']);
