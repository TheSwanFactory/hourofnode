gulp         = require 'gulp'
shell        = require 'gulp-shell'
git          = require 'gulp-git'
release      = require('gulp-release-tasks')(gulp)
source       = require 'vinyl-source-stream'
buffer       = require 'vinyl-buffer'
browserify   = require 'browserify'
browser_sync = require 'browser-sync'
sourcemaps   = require 'gulp-sourcemaps'
sass         = require 'gulp-sass'
prefix       = require 'gulp-autoprefixer'

UPLOAD = 'node aws/upload.js'
dest = 'web'

# TODO: Add gulp test offline test task

# Git functions
handler = (err) -> throw err if err

branch = -> git.revParse 'HEAD', {args: "--abbrev-ref"}, handler

handleError = (error) ->
  console.log error.toString()
  @emit 'end'

# Create bundles using browserify

bundle = (name) ->
  browserify({
    cache: {}, packageCache: {}, fullPaths: true, # watchify
    entries: ["./src/#{name}.coffee"]
    extensions: ['.coffee']
    debug: true # source maps
  })
    .bundle()
    .on('error', handleError)
    .pipe(source("#{name}.js"))
    .pipe(buffer())
    .pipe(sourcemaps.init loadMaps: true)
    .pipe(sourcemaps.write())
    .pipe(gulp.dest "./#{dest}/")

all_builds = ['main']
for build in all_builds
  gulp.task build, -> bundle build

gulp.task 'css', ->
  gulp.src('./src/scss/styles.scss')
    .pipe(sass())
    .on('error', handleError)
    .pipe(prefix())
    .pipe(gulp.dest "./#{dest}/")

# Reload browser using browser-sync

sync_to = (dir) ->
  browser_sync
    server:
      baseDir: ["#{dir}"]
    files:  ["#{dir}/**/*.js", "#{dir}/**/*.css", "#{dir}/**/*.html"]
    open:   true

gulp.task 'sync', -> sync_to dest

# Watch and resync

all_src = ['src/**/*.coffee', 'games/*', './../reactive-coffee/src/*']
gulp.task 'watch', ['sync'], ->
  gulp.watch all_src, all_builds
  gulp.watch ['src/scss/*'], ['css']

# Watch when run

gulp.task 'default', ['main', 'css', 'watch']

# Tag and upload new feature

gulp.task 'upload', shell.task ['node aws/upload.js']
