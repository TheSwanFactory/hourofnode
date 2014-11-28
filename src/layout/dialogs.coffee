{my} = require '../my'
{make} = require '../render/make'

exports.dialogs = (level) ->
  {
    name: "[next]"
    tag_name: 'a'
    href: "#{location.href}?level=2"
  }
