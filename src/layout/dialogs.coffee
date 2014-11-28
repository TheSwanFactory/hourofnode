{my} = require '../my'
{make} = require '../render/make'
queryString = require 'query-string' #https://github.com/sindresorhus/query-string

anchor = (name, dict) -> {
  tag_name: 'a'
  name: name
  href: "/?#{queryString.stringify(dict)}"
}
  
exports.dialogs = (level) ->
  file = level.get 'file'
  end_of_game = level.get 'level_count'
  next_level = 1 + level.get 'level_index'
  console.log 'dialogs', end_of_game, next_level 
  if next_level > end_of_game
    anchor("[next game]", {file: 'tutorial', level: 1})
    # TODO: call up game chooser instead, if we do not replace entirely
  else
    anchor("[next level]", {file: file, level: next_level})
    
