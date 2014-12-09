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
# - Customize Name and Color
# - Select a Sprite
# - Click to Create a Sprite
#
# TODO:
# - Changing the Kinds [popup]
# - Editable and Obstruction [checkbox]
# - Display and Change Direction [popup] N/S/E/W

exports.game = {
  name: 'BETA: Click "Edit" to Modify Levels'
  assume: 'baseline'
  comment: "The followup Hour of NODE tutorial"
  author: {name: 'Ernest Prabhakar', url: 'https://github.com/drernie'}
  license: {
    name: 'Creative Commons Attribution 4.0 International'
    url: 'http://creativecommons.org/licenses/by/4.0/'
  }

  levels: [
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
      name: 'Click Turtle You Want To Program'
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
    {
      name: 'Click Blue Pond to Add and Select Logs'
      editing: true
      comment: '
      Can create arbitrary sprites and program them if in edit mode.
      '
      goal: { clicks: 1, bricks: 2, ticks: 11 }
      bricks: 1
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
      name: 'Create and Share Your Own Level'
      comment: '
      Encourage students to express themselves.
      Track the solution and use that for the new goal metrics.
      After completion, can share via email or social media.
      Will run on our app via a custom URL.
      '
      goal: { clicks: 99, bricks: 99, ticks: 99 }
      bricks: 2
      sprites: [
        { kind: 'gate', actions: {bump: ['_victory']}, position: [7,7] }
        {
          kind: 'turtle'
          actions: {
            run: ['forward']
            bump: ['right']
          }
        }
      ]
    }
  ]
}
