audio = new Audio
sound = null
uri   = null

canPlayOgg = !!audio.canPlayType and audio.canPlayType('audio/ogg; codecs="vorbis"') != ''

if canPlayOgg
  uri = require './beep/ogg'
else
  uri = require './beep/mp3'

sound = new Audio uri

exports.beep = ->
  sound.play()
