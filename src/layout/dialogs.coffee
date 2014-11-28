{my} = require '../my'
{make} = require '../render/make'

exports.dialogs = (level) ->
  {
    name: "[next]"
    tag_name: 'a'
    click: -> window.open(location.href, this.target, "?level=2")
  }
