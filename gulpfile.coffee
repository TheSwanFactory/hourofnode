browserify = require('browserify');
gulp = require('gulp');
source = require('vinyl-source-stream');
 
gulp.task('browserify', ->
  return browserify({
      entries: ['./src/main.coffee'],
      extensions: ['.coffee']
    })
      .bundle()
      .pipe(source('main.js'))
      .pipe(gulp.dest('./web/'));
);

gulp.task('default', ['browserify']);
