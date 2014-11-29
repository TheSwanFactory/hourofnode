{my} = require '../my'
{make} = require '../render/make'
  
exports.dialogs = (level) ->
  make.anchor "skip", level.get 'next_params'
    
