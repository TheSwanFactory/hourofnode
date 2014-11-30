# Creating Games

Games for The Hour of Node are written in NodeScript, a stylized subset of CoffeeScript (which itself is a variant of JavaScript).

NodeScript consists of a series of nested dictionaries of the form `{ key: 'value' }`, specifying names, levels, and sprites. Note that you must indent your dictionaries properly to avoid confusing the CoffeeScript parser.

Every sprite must have a kind and position, and may have a name and actions.

# TODO: describe actions