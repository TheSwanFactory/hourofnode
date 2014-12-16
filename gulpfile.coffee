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
exitCode = 0

# Git functions
handler = (err) -> throw err if err

branch = -> git.revParse 'HEAD', {args: "--abbrev-ref"}, handler

handleError = (error) ->
  console.log error.toString()
  exitCode = 1
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

# testing

test_bundle = (build) ->
  browserify({
    cache: {}, packageCache: {}, fullPaths: true, # watchify
    entries: ["./test/#{build}.coffee"]
    extensions: ['.coffee']
    debug: true
  })
    .bundle()
    .on('error', handleError)
    .pipe(source("#{build}.js"))
    .pipe(buffer())
    .pipe(sourcemaps.init loadMaps: true)
    .pipe(sourcemaps.write())
    .pipe(gulp.dest "./test/")

test = (build) -> shell.task ['mocha-phantomjs web/test.html']

all_builds = ['main']
for build in all_builds
  gulp.task build,                  -> bundle build
  gulp.task "test:#{build}:bundle", -> test_bundle build
  gulp.task "test:#{build}",        ["test:#{build}:bundle"], test build

# Watch and resync

all_src = ['src/**/*.coffee', 'games/*', './../reactive-coffee/src/*']
all_src_with_test = all_src.concat ['test/**/*.coffee']
gulp.task 'watch', ['sync'], ->
  gulp.watch all_src, all_builds
  gulp.watch all_src_with_test, all_builds.map((build) -> "test:#{build}")
  gulp.watch ['src/scss/*'], ['css']

# Watch when run

gulp.task 'default', ['main', 'css', 'watch']

# Tag and upload new feature

gulp.task 'upload', shell.task ['node aws/upload.js']
gulp.task 'upload:dev', shell.task ['node aws/upload.js dev']

process.on 'exit', ->
  process.exit exitCode
