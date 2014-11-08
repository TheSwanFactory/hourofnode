# Getting Started with the Code

## Reading the Code

### CoffeeScript

The source code is written in _CoffeeScript_:

* http://coffeescript.org

The CoffeeScript is compiled into _JavaScript_, the language that runs inside web browsers:

* http://en.wikipedia.org/wiki/JavaScript
* http://www.w3schools.com/js/default.asp

The compilation is done using a system called _node_ that allows JavaScript tools to run outside the browser. We use _npm_ to install the modules we rely upon as described in the package.json file, and _Gulp_ to coordinate the compilation and other development tasks:

* http://nodejs.org
* https://www.npmjs.org
* http://gulpjs.com

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
  * http://www.w3schools.com/html/
  default.asp
  * http://www.w3schools.com/svg/default.asp

This allows us to write very simple declarative code describing our web pages, have the system automatically generate those pages AND keep them up to date when we change the underlying values.

The main methods we are using will be:

  doc.put 'key', value # store a value
  doc.get 'key'        # retrieve a value
  
  T.div {attributes}, [elements] # HTML node
  SVG.path {attributes}, [elements] # SVG node
  
### Object Model

However, we do not write very much reactive coffee directly. Instead, for various reasons we touch upon in DESIGN.md, we create our own _object model_ on top of Reactive Coffee.  An object model is a way of organizing our methods to make it easier to see what we are doing. This requires three main things:

* a _data format_ for describe our objects
* _factories_ for creating the objects
* a _runtime_ for interpreting the objects

We call our objects 'worlds', since they represent a unique 'worldview' onto the rest of the program.

Our data format is CoffeeScript dictionaries, which look like:
  {
    static_property: value
    dynamic_property: (world) -> world.calculate()
    callable_method: (world, args) -> actions
  }
These dictionaries live under 'config' in the source code.

Our primary factory is the 'god' object, which stands for _Global Object Domain_.  

Our runtime is contained in the World object, defined in `god/world.coffee`.  The primary job of the runtime is to loosely map names (or 'keys') to values and actions.  

### Games

### Test
_[still under construction]_

#### Unit Testing


#### Components
* tape test harness
* tap file format & formatters
* in-browser execution
* conditional running
  * my.test if not in production
* Uses games/game-testing.coffee as a 'fixture'
  


