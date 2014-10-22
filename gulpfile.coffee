gulp = require 'gulp'
release = require('gulp-release-tasks')(gulp)
source = require 'vinyl-source-stream'
browserify = require 'browserify'
browser_sync = require 'browser-sync'

# Create bundles using browerify

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

all_builds = ['main']
for build in all_builds
  gulp.task build, -> bundle build


# Reload browser using browser-sync

sync_to = (dir) ->
  browser_sync {
    server: {baseDir: ["#{dir}"]}
    files: ["#{dir}/*"]
  }

dest = 'web'
gulp.task 'sync', -> sync_to 'web'  

# Watch and resync

all_src = ['src/*', 'src/*/*', '../reactive-coffee/src/*']
gulp.task 'watch', ['sync'], ->
  gulp.watch all_src, all_builds  
  
# Watch when run

gulp.task 'default', ['watch']
