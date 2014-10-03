# Preamble

{items} = require('./model')

tags = ['svg','g','rect', 'circle', 'ellipse', 'line', 'polyline', 'polygon', 'path', 'marker', 'text', 'tspan', 'tref', 'textpath', 'switch', 'image', 'a', 'defs', 'symbol', 'use', 'animateTransform', 'stop', 'linearGradient', 'radialGradient', 'pattern', 'clipPath', 'mask', 'filter', 'feMerge', 'feOffset', 'feGaussianBlur', 'feMergeNode']
T = _.object([tag, rxt.mktag(tag)] for tag in tags)

_.mixin(_.str.exports())
bind = rx.bind
rxt.importTags()

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

main = ->

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
    T.svg {class: 'graphics'},[
     T.rect {x:10, y:20, height:100, width:100, fill:"blue", stroke: "red"}, [
       T.animateTransform({
        attributeName: "transform"
        begin: "0s"
        dur: "20s"
        type: "rotate"
        from: "0 60 60"
        to: "360 60 60"
        repeatCount: "indefinite" 
       })
     ] 
    ]
  )

# Instantiate our main view
$(main)
