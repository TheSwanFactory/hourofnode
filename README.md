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
  
Note that while we use node and browserify to build our application, we are not currently using node streams for our in-app event architecture.  Instead, we use a mix of [Reactive Coffee](http://yang.github.io/reactive-coffee/) and custom event handlers.


  
