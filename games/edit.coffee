#
# edit.coffee
#
# The followup Hour of Node Tutorial
#
# Role: explain how to create and share your own levels
#
# Key Interface Elements:
# * edit / save
# * action bricks (forward, right, left)
# * run program (run loop)
# * bump program (interrupt handler)

# TODO:
# Gate by default should send _victory action when interrupted
# Turtle defaults to reverse on interrupt, to avoid invisible loop
# Implicitly add: assume, per-level turtle and gate (if absent)
# Check and send 'done -1' if infinite loop (e.g., no interrupt)

# COMMENT
# Scores for each level are based on analogs of real-world metrics
# - Clicks (programmer hours)
# - Bricks (lines of code)
# - Ticks (execution time)
# [with apologies to Dr. Seuss and "Fox in Socks"]
#
# Advanced players seeking to optimize their score will need to make
# similar tradeoffs to what we faced in writing this app!
#

exports.game = {
  name: 'Use "Edit" to Modify Level'
  assume: 'baseline'
  comment: "The followup Hour of NODE tutorial"
  author: {name: 'Ernest Prabhakar', url: 'https://github.com/drernie'}
  license: {
    name: 'Creative Commons Attribution 4.0 International'
    url: 'http://creativecommons.org/licenses/by/4.0/'
  }

  levels: [
    {
      name: 'Click "Play" to Move Turtle to Exit Pad'
      comment: '
      Teach kids to use a run loop rather than direct manipulation.
      They can also experiment with the other control buttons.
      Everything else is disabled to avoid confusion.
      '
      message: 'You did it!'
      bricks: 1
      action_limit: 1
      goal: { clicks: 0, bricks: 1, ticks: 4 }
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [1,1] }
        { kind: 'turtle', actions: {run: ['forward', 'right']}, editable: false }
      ]
    }
    {
      name: 'Click "Edit" to Modify. Click Sprite to Modify.'
      comment: '
      Now students know enough to start designing their own levels.
      - Click "Edit" to enable design mode.
      - Click on the Blue Grid to create more sprites.
      NOTE: edit mode is usually disabled the first time through a level
      '
      edit_mode: true
      bricks: 2
      goal: { clicks: 1, bricks: 2, ticks: 11 }
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [4,4] }
        {
          kind: 'turtle'
          actions: { run: ['forward'], interrupt: ['right'] }
        }
      ]
    }
    # TODO: change the kind of sprite
    # TODO: replace level and game description
  ]
}
