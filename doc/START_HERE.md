# Getting Started with the Code

## Reading the Code

### CoffeeScript

The source code is written in _CoffeeScript_:

* http://coffeescript.org

The CoffeeScript is compiled into _JavaScript_, the language that runs inside web browsers:

* http://en.wikipedia.org/wiki/JavaScript
* http://www.w3schools.com/js/default.asp

The good news is that you don't need to know a lot about these languages.  The main thing you need to know is that we are creating _methods_ that perform various _actions_ using _arguments_. The syntax used by CoffeeScript to create methods is:

  method = (arguments) -> actions
  
### Reactive Coffee

On top of CoffeeScript we are using a framework (a library or set of tools) called _Reactive Coffee_:

* http://yang.github.io/reactive-coffee/
* https://github.com/yang/reactive-coffee

Reactive Coffee provides two really useful things for our purposes:

* Reactive 'cells' that are synchronized across different parts of the app
  * http://en.wikipedia.org/wiki/Reactive_programming
  * (Intro to RX)[https://gist.github.com/staltz/868e7e9bc2a7b8c1f754]
  * http://yang.github.io/reactive-coffee/tutorial.html#cells

* A 'template engine' for generate HTML (web pages) and SVG (graphics)
  * http://yang.github.io/reactive-coffee/tutorial.html#static-templates
  * http://www.w3schools.com/html/default.asp
  * http://www.w3schools.com/svg/default.asp

This allows us to write very simple declarative code describing our web pages, have the system automatically generate those pages AND keep them up to date when we change the underlying values.

The main methods we are using will be:

  doc.put 'key', value # store a value
  doc.get 'key'        # retrieve a value
  
  T.div {attributes}, [elements] # HTML node
  SVG.path {attributes}, [elements] # SVG node
  
### Reactive Coffee

  