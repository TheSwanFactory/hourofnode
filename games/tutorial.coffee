# Gate by default should send _victory action when interrupted
# Turtle defaults to reverse on interrupt, to avoid invisible loop

# TODO:
# Implicitly add: assume, per-level turtle and gate (if absent)
# Check and send 'done -1' if infinite loop (e.g., no interrupt)

exports.game = {
  name: 'The Hour of NODE'
  assume: 'baseline'
  comment: "The world's first Hour of NODE game"
  author: {name: 'David Huffman', url: 'mailto:david%40theswanfactory.com'}
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
      bricks: 1
      action_limit: 1
      goal: { clicks: 0, ticks: 4, bricks: 1 }
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [1,1] }
        { kind: 'turtle', actions: {run: ['forward', 'right']}, editable: false }
      ]
    }
    {
      name: 'Click "Right" Program Brick to Remove It From "Run".'
      comment: '
      Introduce kids to the concept of an editable program buffer.
      This is an example of debugging an existing program.
      '
      goal: { clicks: 1, ticks: 6, bricks: 1 }
      bricks: 2
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [5,0] }
        { kind: 'turtle', actions: {run: ['forward', 'right']}, editable: false }
      ]
    }
    # TODO: add a level explaining how/why to rearrange bricks
    {
      name: 'Click "Forward" Brick to Create A Run Program'
      comment: '
      Start using program bricks to create their own programs.
      Limit actions to 2 to avoid brute force non-run-loop solutions.
      '
      goal: { clicks: 1, ticks: 8, bricks: 1 }
      action_limit: 2
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [7,0] }
        { kind: 'turtle', actions: {} }
      ]
    }

    {
      name: 'Use Bricks to Move Diagonally'
      goal: { clicks: 2, ticks: 12, bricks: 4 }
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [4,4] }
        { kind: 'turtle', actions: {} }
      ]
    }
    {
      name: 'Use "Interrupt" Program to Bounce Off Walls'
      goal: { clicks: 1, ticks: 10, bricks: 1 }
      bricks: 1
      sprites: [
        { kind: 'wall', position: [5,0] }
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
      goal: { clicks: 2, ticks: 10, bricks: 2 }
      sprites: [
        { kind: 'wall', position: [5,0] }
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [4,4] }
        { kind: 'turtle', actions: {interrupt: []} }
      ]
    }
    {
      name: 'Can You Solve the Final Complex Maze?'
      goal: {
        clicks: 6
        ticks: 20
        bricks: 6
      }
      sprites: [
        {kind: 'gate', actions: {interrupt: ['_victory']}}
        {kind: 'wall'}
        {kind: 'wall', position: [0,2]}
        {kind: 'wall', position: [2,2]}
        {kind: 'wall', position: [2,1]}
        {kind: 'wall', position: [2,0]}
        {kind: 'wall', position: [2,5]}
        {kind: 'wall', position: [1,5]}
        {kind: 'wall', position: [3,5]}
        {kind: 'wall', position: [4,5]}
        {kind: 'wall', position: [5,5]}
        {
          kind: 'turtle'
          position: [0,0]
        }
      ]
    }
    {
      name: 'Replay Levels to Enable Edit Mode. Click to Add Walls.'
      edit_mode: true
      goal: { clicks: 2, ticks: 10, bricks: 2 }
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']} }
        { kind: 'turtle' }
      ]
    }
    {
      name: 'Click on Pond to Add Walls'
      goal: { clicks: 1, ticks: 10, bricks: 1 }
      bricks: 1
      sprites: [
        { kind: 'gate', actions: {interrupt: ['_victory']}, position: [4,4] }
        {
          kind: 'turtle'
          actions: { run: ['forward'], interrupt: ['right'] }
          editable: false
        }
      ]
    }
  ]
}
