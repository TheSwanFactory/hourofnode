beep = null

if typeof Audio == 'undefined'
  beep = -> null
else
  audio = new Audio
  sound = null
  uri   = null

  canPlayOgg = !!audio.canPlayType and audio.canPlayType('audio/ogg; codecs="vorbis"') != ''

  if canPlayOgg
    uri = require './beep/ogg'
  else
    uri = require './beep/mp3'

  sound = new Audio uri

  beep = -> sound.play()

exports.beep = beep
