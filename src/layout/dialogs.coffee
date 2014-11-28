{my} = require '../my'
{make} = require '../render/make'
queryString = require 'query-string' #https://github.com/sindresorhus/query-string

anchor = (name, dict) -> {
  tag_name: 'a'
  name: name
  href: "#{location.href}?#{queryString.stringify(dict)}"
}
  
exports.dialogs = (level) ->
  anchor("[next]", {level: 2})
