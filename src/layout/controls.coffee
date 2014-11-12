{my} = require '../my'
{rows, cols} = require './rows_cols'

exports.controls = 
  cols 'status', ["step", "run", "stop", "reset"]
