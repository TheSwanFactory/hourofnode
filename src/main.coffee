# Preamble
_.mixin(_.str.exports())
bind = rx.bind
rxt.importTags()

model = require('../lib/model')
console.log model.items

# Generic Editor component

editor = (opts) ->
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

# Define our main view

main = (items) ->

  # Reactive cell to track currently selected item
  # Default is the first item
  currentItem = rx.cell(items.at(0)) 

  $('body').append(
    div {class: 'item-manager'}, [
      h1 bind -> "#{items.length()} Items"
    
      # Display list of existing items
        
      ul {class: 'items'}, items.map (item) ->
        li {
          class: 'item'            
          # Animate creation with JQuery efffect
          init: -> _.defer => @slideDown('fast')
        }, [
          span {
            class: 'data'
          }, bind -> "#{item.data.get()} "
          a {
            href: 'javascript: void 0'
            click: -> currentItem.set(item)
          }, 'Edit'
        ]

      # Create a new item
       
      button {
        click: ->
          title = "Item ##{items.length()+1}"
          items.push(new Item(title))
      }, 'Add Item'

      # Edit selected item
        
      editor {
        item: bind -> currentItem.get()
        onSubmit: (data) ->
          currentItem.get().data.set(data)
      }
    ]
  )

# Instantiate our main view
$(main(model.items))
