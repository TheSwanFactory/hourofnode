#
# edit.coffee
#
# The followup Hour of Node Tutorial
#
# Role: explain how to create and share your own levels
#

exports.game = {
  name: 'Use "Edit" to Modify Levels'
  assume: 'baseline'
  comment: "The followup Hour of NODE tutorial"
  author: {name: 'Ernest Prabhakar', url: 'https://github.com/drernie'}
  license: {
    name: 'Creative Commons Attribution 4.0 International'
    url: 'http://creativecommons.org/licenses/by/4.0/'
  }

  levels: [
    {
      name: 'Click "Edit" to Modify and "Save" when Done.'
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
