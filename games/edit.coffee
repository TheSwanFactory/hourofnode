#
# edit.coffee
#
# The followup Hour of Node Tutorial
#
# Role: explain how to create and share your own levels
#
# Responsible to Teach:
#
# - Edit / Save Controls
# - Renaming the Level
# - Select a Sprite
# - Click to Create a Sprite
# - Customize Name and Color
#
# TODO:
# - Changing the Kinds [popup]
# - Editable and Obstruction [checkbox]

exports.game = {
  name: 'BETA: Use "Edit" to Modify Levels'
  assume: 'baseline'
  comment: "The followup Hour of NODE tutorial"
  author: {name: 'Ernest Prabhakar', url: 'https://github.com/drernie'}
  license: {
    name: 'Creative Commons Attribution 4.0 International'
    url: 'http://creativecommons.org/licenses/by/4.0/'
  }

  levels: [
    {
      name: '"Save" then Solve in order to Share'
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
      name: 'Click to Select Turtle Being Programmed'
      comment: '
      Can select multiple turtles which act independently.
      This is a primitive form of parallel processing.
      Optimal solution is to move the blocking turtle.
      '
      edit_mode: true
      bricks: 2
      goal: { clicks: 1, bricks: 3, ticks: 5 }
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [4,0] }
        {
          kind: 'turtle'
          name: 'yu'
          position: [2,0]
          direction: [0, 1]
          fill: 'purple'
          actions: { run: [], bump: [] }
        }
        {
          kind: 'turtle'
          actions: { run: ['forward'], bump: ['right'] }
        }
      ]
    }
  ]
}
