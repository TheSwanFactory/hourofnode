gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'

bundle = (name) ->
  browserify({
    entries: ["./src/#{name}.coffee"],
    extensions: ['.coffee']
  })
    .bundle()
    .pipe(source("#{name}.js"))
    .pipe(gulp.dest('./web/'));
 
gulp.task 'main', -> bundle('main')
gulp.task 'test', -> bundle('test')

gulp.task('default', ['main', 'test']);
