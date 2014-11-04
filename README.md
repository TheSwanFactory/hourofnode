# The Hour of Node

## Turning event-driven programming into child's play

### Introduction

The Hour of Node is a single-page web application designed to teach event-driven programming to kids of all ages, backgrounds, and experience levels.

    http://hourofnode.org

It includes:

 * **TurtleVerse 2D**, a simple yet extensible game engine 
 * A **Graphical Command Interface** (GCI) that seamlessly incorporates both playing and programming the game engine
 * **Tutorials** that teach kids how to use the GCI and TurtleVerse 2D

We believe this is the first comprehensive programming environment -- GUI, game engine, runtime, and document format -- designed from the ground up for kids (and the iPad). Our goal is to build something simple enough for grade-schoolers to learn in an hour, yet rich enough to keep teenagers busy for days. 

We began development on October 1st, 2014, and plan to launch on December 8th, 2014 for CS Education Week (aka The Hour of Code). We are live-casting our coding sessions at:

    https://plus.google.com/u/0/b/114923971860716198524/events

and publishing our code at:

    https://github.com/TheSwanFactory/hourofnode

Please join us! We can use all the help we can get. :-)

### Getting Started

[Note: *these instructions are preliminary and haven't been tested*]

    $ open http://howtonode.org/how-to-install-nodejs # Install Node
    $ npm install # Install all required node packages, from package.json
    $ gulp # builds, watches, and launches browser

### Design Notes

The design of the Hour of Node is driven by two key principles:

 * Express code semantics in documents rather than language
 * Communicate between modules using events rather than direct invocation

#### Documents

A key premise of The Hour of Node is that human language is a dangerous metaphor for thinking about programming. For over fifty years, we have forced students to grapple with complicated syntax in order to do high-level programming.  Not only is this a huge barrier to entry, it also completely obscures the underlying semantics.

To solve that problem, we are working towards expressing the bulk of our semantics via simple JSON documents, located in the `config` directory. These documents are used to create `world` objects, which sharing information using scoped inheritance and distributed events.  In addition to clarifying the otherwise hidden structure of our code, these documents make it trivial to map the low-level (JavaScript) implementation onto the high-level (graphical) interface.

#### Events

Note that while we use node and browserify to build our application, we are not currently using node streams for our in-app event architecture.  Instead, we use a mix of [Reactive Coffee](http://yang.github.io/reactive-coffee/) and custom event handlers.

Properly handling events is a key performance challenge. We can only afford to update precisely those elements that have changed.   Reactive Coffee provides an elegant 'bind' mechanism for doing the updates, but we need to only invoke it on the smallest visual element that actually changes.  Otherwise, we waste too much time redrawing things that do not change.

Below are the most significant events and the things they affect:

##### Step

 * Time and click count
 * Every turtle's position on canvas
 * Selected turtle's position reported in the inspector
 * Highlighted action
 * May fire other events
 
##### Command

 * Click count
 * Appends command to current program in inspector
 
##### Select

 * Entire inspector
 
Of these, _step_ must be extremely fast since it runs automatically, _command_ must be relatively fast since the user may click it repeatedly, but _select_ can take a while (though still be low latency) since the user will click it and then look.
