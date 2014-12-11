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
# - Gate by default should send _victory action when bumped
# - Turtle defaults to reverse on bump, to avoid invisible loop
# - Implicitly add: assume, per-level turtle and gate (if absent)
# - Check and send 'done -1' if infinite loop (e.g., no bump)
# - Edit Level Name and non-text status items

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
# TODO: Use Markdown instead of embedded HTML

more_puzzles = 'http://support.hourofnode.org/questions/10/where-can-i-find-additional-hour-of-node-puzzles.html'
SURVEY='https://docs.google.com/forms/d/1ovfw26rDoWGoxEGLV8HjPxmVmBMpuJIpi9ZExIfvRCU/viewform?usp=send_form'

exports.game = {
  assume: 'baseline'
  name: 'The Hour of NODE'
  comment: "The original Hour of NODE tutorial for CS Education Week 2014"
  description: 'Welcome to <b>Hour of NODE</b>, the hackable way
  to learn event-driven programming
  as part of <a href="http://code.org/">CS Education Week</a>.'
  completion: "
  Thanks for playing through the Hour of NODE tutorial.<br/>
  We encourage you to continue creating and sharing your own levels.
  You can publish and find new levels, plus ask questions, at
  <a href='#{more_puzzles}' target='_blank'>support site</a>.<br/>
  Please help us improve the app by
  <a href='#{SURVEY}' target='_blank'>answering a few questions</a> about your experience.
  Thanks!
  "
  author: {name: 'David Huffman', url: 'https://github.com/huffmande'}
  license: {
    name: 'Creative Commons Attribution 4.0 International'
    url: 'http://creativecommons.org/licenses/by/4.0/'
  }
  message: 'Congratulations!'
  levels: [
    {
      name: 'Click "Run" Button to Move Turtle to Exit Pad'
      focus: 'run'
      comment: '
      Explain the use of the "Run" Control.
      They can also experiment with the other control buttons.
      Everything else is disabled to avoid confusion.
      '
      message: 'You did it!'
      bricks: 2
      goal: { clicks: 0, bricks: 2, ticks: 4 }
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [1,1] }
        { kind: 'turtle', actions: {run: ['forward', 'right']} }
      ]
    }
    {
      name: 'Watch "On Run" Program Loop Over Bricks'
      focus: 'run'
      comment: '
      Teach kids to use a run loop rather than brute force.
      Introduce the idea of action bricks.
      '
      message: 'Awesome!'
      bricks: 4
      goal: { clicks: 0, bricks: 4, ticks: 12 }
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [3,3] }
        {
          kind: 'turtle'
          actions: {
            run: ['forward', 'right', 'forward', 'left']
            bump: ['right'] }
          editable: false
        }
      ]
    }
    {
      name: 'Click "Forward" Brick to Create "Run" Program'
      focus: 'forward'
      comment: '
      Start using program bricks to create their own programs.
      '
      message: 'Great job!'
      goal: { clicks: 1, bricks: 1, ticks: 8 }
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [7,0] }
        { kind: 'turtle', actions: {} }
      ]
    }
    {
      name: 'Click Just One Brick to Get Three Gold Stars'
      focus: 'forward'
      comment: '
      Encourage more concise code.
      Humans can usually only handle 7+-2 items in short-term memory.
      Well-factored programs typically only have 7 lines per method, so
      we limit programs to length 7 (1 here, for teaching purposes).
      '
      message: 'Way to go!'
      action_limit: 1
      goal: { clicks: 1, bricks: 1, ticks: 8 }
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [7,0] }
        { kind: 'turtle', actions: {} }
      ]
    }
    {
      name: 'Click "Right" Program Brick to Remove It'
      comment: '
      Introduce kids to the concept of an editable program buffer.
      This is an example of debugging an existing program.
      '
      goal: { clicks: 1, bricks: 1, ticks: 6 }
      bricks: 2
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [5,0] }
        { kind: 'turtle', actions: {run: ['forward', 'right']} }
      ]
    }
    # TODO: add a level explaining how/why to rearrange bricks
    # TODO: Explain Left-Right
    {
      name: 'Use Both "Left" & "Right" to Move Diagonally'
      comment: '
      Create a multi-stage program.
      Can get top score by using run loop to avoid final "Forward"s
      '
      goal: { clicks: 4, bricks: 4, ticks: 8 }
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [2,2] }
        { kind: 'turtle', actions: {} }
      ]
    }
    {
      name: 'Watch "On Bump" Bounce Off Edge and Logs'
      focus: 'run'
      comment: '
      Shows the power of reactive programming.
      Introduces concept of an interrupt handler.
      '
      goal: { clicks: 0, bricks: 6, ticks: 13 }
      bricks: 6
      sprites: [
        { kind: 'log', position: [0,2] }
        { kind: 'gate', actions: {bump: ['_victory']}, position: [4,2] }
        {
          kind: 'turtle'
          actions: {
            run: ['forward', 'left', 'forward']
            bump: ['reverse', 'reverse', 'reverse']
          }
          editable: false
        }
      ]
    }
    {
      name: 'Click "On Bump" to Add Bricks to that Program'
      focus: 'on bump'
      comment: '
      Get students to create their own interrupt handler!!!

      Notice how natural such an advanced concept feels in this environment.
      Developed during Ship Week 1.2 on the AwesomeStuffBadly YouTube Channel
      For implementation details, see files in src/layout/mixins
      - events.coffee : step
      - programs.coffee : prefetch
      - sprites.coffee : collision
      '
      goal: { clicks: 1, bricks: 2, ticks: 11 }
      bricks: 1
      sprites: [
        { kind: 'log', position: [5,0] }
        { kind: 'gate', actions: {bump: ['_victory']}, position: [4,4] }
        {
          kind: 'turtle'
          actions: {
            run: ['forward']
            bump: []
          }
          solution: {
            run: ['forward']
            bump: ['right']
          }
        }
      ]
    }
    {
      name: 'Use "Run" and "Bump" to Solve the Final Maze'
      comment: '
      The simplest solution is the same as the last one!
      Imagine trying to solve this procedurally, as in other tutorials.
      '
      goal: { clicks: 2, bricks: 2, ticks: 29 }
      sprites: [
        {kind: 'gate', actions: {bump: ['_victory']}}
        {kind: 'log'}
        {kind: 'log', position: [0,2]}
        {kind: 'log', position: [2,2]}
        {kind: 'log', position: [2,1]}
        {kind: 'log', position: [2,0]}
        {kind: 'log', position: [2,5], color: 'brown', direction: [0,1]}
        {kind: 'log', position: [1,5], color: 'brown', direction: [0,1]}
        {kind: 'log', position: [3,5], color: 'brown', direction: [0,1]}
        {kind: 'log', position: [4,5], color: 'brown', direction: [0,1]}
        {kind: 'log', position: [5,5], color: 'brown', direction: [0,1]}
        {
          kind: 'turtle'
          position: [0,0]
        }
      ]
    }
    {
      name: 'Click Other Turtles To Program Them'
      comment: '
      Can select multiple turtles which act independently.
      This is a primitive form of parallel processing.
      Optimal solution is to move the distant turtle.
      '
      edit_mode: true
      bricks: 2
      goal: { clicks: 1, bricks: 3, ticks: 3 }
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [4,0] }
        {
          kind: 'turtle'
          name: 'yu'
          position: [2,0]
          direction: [0, 1]
          color: 'red'
          actions: { run: [], bump: [] }
        }
        {
          kind: 'turtle'
          name: 'us'
          position: [6,0]
          direction: [-1, 0]
          color: 'blue'
          actions: { run: [], bump: [] }
        }
        {
          kind: 'turtle'
          actions: { run: ['forward'], bump: ['right'] }
        }
      ]
    }
    {
      name: 'Click "Edit" to Modify; "Save" and "Run" to Share'
      comment: '
      Can edit the level name, sprite name, and sprite color. (DEVELOP)
      Must first solve the puzzle to validate it. (TEST)
      Can then share it from the post-level splash screen. (DEPLOY)
      Affirms the importance of good integration testing!
      '
      edit_mode: true
      bricks: 2
      goal: { clicks: 1, bricks: 2, ticks: 5 }
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [4,0] }
        {
          kind: 'turtle'
          actions: { run: ['forward'], bump: ['right'] }
        }
      ]
    }
    {
      name: 'Click "Edit" & Blue Area to Add & Select Logs'
      editing: true
      comment: '
      Can create arbitrary sprites and program them if in edit mode.
      '
      goal: { clicks: 1, bricks: 2, ticks: 11 }
      bricks: 2
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [4,4] }
        {
          kind: 'turtle'
          actions: {
            run: ['forward']
            bump: ['right']
          }
        }
      ]
    }
    {
      name: 'Click "Edit", "log", then "delete" to Remove'
      editing: true
      comment: '
      Can create arbitrary sprites and program them if in edit mode.
      '
      goal: { clicks: 1, bricks: 2, ticks: 5 }
      bricks: 2
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [4,0] }
        { kind: 'log', position: [2,0] }
        {
          kind: 'turtle'
          actions: {
            run: ['forward']
            bump: ['right']
          }
        }
      ]
    }
    {
      name: 'Use "Edit" to Create, Test & Share Your Level'
      comment: '
      Encourage students to express themselves.
      Track the solution and use that for the new goal metrics.
      After completion, can share via email or social media.
      Will run on our app via a custom URL.
      '
      goal: { clicks: 99, bricks: 99, ticks: 99 }
      bricks: 2
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [7,3] }
        {
          kind: 'turtle'
          actions: {
            run: ['forward']
            bump: ['right']
          }
          position: [0,3]
        }
      ]
    }
  ]
}
