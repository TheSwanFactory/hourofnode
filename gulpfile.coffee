gulp = require 'gulp'
shell = require 'gulp-shell'
git = require 'gulp-git'
release = require('gulp-release-tasks')(gulp)
source = require 'vinyl-source-stream'
browserify = require 'browserify'
browser_sync = require 'browser-sync'

UPLOAD = 'node aws/upload.js'

# Git functions

branch = -> git.revParse 'HEAD', {args: "--abbrev-ref"}

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

gulp.task 'default', ['main', 'watch']
  
# Upload to S3

gulp.task 'upload', shell.task(['node aws/upload.js'])

# Tag and upload new feature

gulp.task 'ship', ['tag', 'upload']

# Push branch changes to master and github
gulp.task 'merge', ->
  current = branch()
  git.checkout 'master'
  git.merge current, ((err) -> if (err) throw err)
  git.checkout current

