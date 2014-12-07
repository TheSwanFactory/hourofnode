#
# tutorial.coffee
#
# The Primary Hour of Node Tutorial
#
# Role: explain how to use the interface to program turtles to reach the exit
#
# Key Interface Elements:
# * run button
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
  name: 'The Hour of NODE'
  assume: 'baseline'
  comment: "The original Hour of NODE tutorial"
  author: {name: 'David Huffman', url: 'https://github.com/drernie'}
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
    # TODO Explain Left-Right
    # TODO Explain Limits
    {
      name: 'Click "Right" Program Brick to Remove It'
      comment: '
      Introduce kids to the concept of an editable program buffer.
      This is an example of debugging an existing program.
      '
      goal: { clicks: 1, bricks: 1, ticks: 6 }
      bricks: 2
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [5,0] }
        { kind: 'turtle', actions: {run: ['forward', 'right']} }
      ]
    }
    # TODO: add a level explaining how/why to rearrange bricks
    {
      name: 'Click "Forward" Brick to Create A Run Program'
      comment: '
      Start using program bricks to create their own programs.
      Limit actions to 2 to avoid brute force non-run-loop solutions.
      '
      message: 'Great job!'
      goal: { clicks: 1, bricks: 1, ticks: 8 }
      action_limit: 2
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [7,0] }
        { kind: 'turtle', actions: {} }
      ]
    }
    {
      name: 'Use Only Four Bricks to Move Diagonally'
      comment: '
      Create a multi-stage program.
      Can get top score by using run loop to avoid final "Forward"s
      '
      goal: { clicks: 4, bricks: 4, ticks: 8 }
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [2,2] }
        { kind: 'turtle', actions: {} }
      ]
    }
    {
      name: 'Use "Interrupt" Program to Bounce Off Logs'
      comment: '
      Shows the power of reactive programming.
      Introduces concept of an interrupt handler.
      '
      goal: { clicks: 0, bricks: 2, ticks: 11 }
      action_limit: 2
      bricks: 2
      sprites: [
        { kind: 'log', position: [5,0] }
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [4,4] }
        {
          kind: 'turtle'
          actions: { run: ['forward'], interrupt: ['right'] }
          editable: false
        }
      ]
    }
    {
      name: 'Click "Interrupt" to Add Bricks to that Program'
      comment: '
      Get students to create an interrupt handler!!!

      Notice how natural such an advanced concept feels in this environment.
      Developed during Ship Week 1.2 on the AwesomeStuffBadly YouTube Channel
      For implementation details, see files in src/layout/mixins
      - events.coffee : step
      - programs.coffee : prefetch
      - sprites.coffee : collision
      '
      goal: { clicks: 1, bricks: 2, ticks: 12 }
      bricks: 1
      sprites: [
        { kind: 'log', position: [5,0] }
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [4,4] }
        { kind: 'turtle', actions: {run: ['forward'], interrupt: []} }
      ]
    }
    {
      name: 'Can You Solve the Ultimate Maze?'
      comment: '
      The simplest solution is the same as the last one!
      Imagine trying to solve this procedurally, as in other tutorials.
      '
      goal: { clicks: 2, bricks: 2, ticks: 29 }
      sprites: [
        {kind: 'gate', actions: {interrupt: ['_victory']}}
        {kind: 'log'}
        {kind: 'log', position: [0,2]}
        {kind: 'log', position: [2,2]}
        {kind: 'log', position: [2,1]}
        {kind: 'log', position: [2,0]}
        {kind: 'log', position: [2,5]}
        {kind: 'log', position: [1,5]}
        {kind: 'log', position: [3,5]}
        {kind: 'log', position: [4,5]}
        {kind: 'log', position: [5,5]}
        {
          kind: 'turtle'
          position: [0,0]
        }
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
