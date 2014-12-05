{my} = require '../my'
{vector} = require '../god/vector'
queryString = require 'query-string'

group = (label, items, tag_name, options = {}) ->
  _.extend({},
    {
      _KIND: label
      _AUTHORITY: {tag_name: tag_name}
      _LABEL: label
      _CHILDREN: items
    },
    options
  )

exports.make = {
  rows: (label, items, options) -> group label, items, 'div', options
  columns: (label, items, options) -> group label, items, 'span', options
  anchor: (name, params) -> {
    tag_name: 'a'
    name: name
    href: "/?#{queryString.stringify(params)}"
  }

  buttons: (kind, items, my_kind, action, more_authority={}) ->
    label = "#{kind}s"
    base_authority = {
      tag_name: 'button'
      _KIND: kind
      padding: my_kind.padding
      height: my_kind.size - 4 * my_kind.padding
      width: my_kind.size + 2 * my_kind.padding
      x: (button) -> button.get 'offset'
      y: 0
      click: action
    }
    children = items.map (item) -> {
      _LABEL: item
      name: item
      value: item
      class: my_kind.class
    }
    {
      _KIND: label
      _AUTHORITY: _.extend base_authority, more_authority
      _LABEL: label
      _CHILDREN: children
      stroke: my.color.line
    }
}
