# Generic Editor component

exports.editor = (opts) ->
  item = -> opts.item.get()
  theForm = form [
    h2 'Edit Item'
    data = input {
      type: 'text',
      value: bind -> item().data.get()
    }
    button 'Update'
  ]
  # Validate/munge submitted data
  # We could've also made this a `submit`
  # property on the `form` element above
  theForm.submit ->
    opts.onSubmit(data.val().trim())
    false
