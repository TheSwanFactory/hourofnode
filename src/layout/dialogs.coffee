{my} = require '../my'
{make} = require '../render/make'

anchor = (name, next_url) -> {
  tag_name: 'a'
  name: name
  href: next_url
}
  
exports.dialogs = (level) ->
  anchor "skip", level.get 'next_url'
    
