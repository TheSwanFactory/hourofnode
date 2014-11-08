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

#### Setup Git

* Sign up for a Github account: https://github.com
* Launch a Terminal (Mac: Utilities, Windows: CMD Prompt or CygWin)
* Install GIT on your machine: 
  * https://help.github.com/articles/set-up-git/
  * http://www.git-scm.com/downloads

#### Download the project

* Fork the project: "Fork" button on upper right of this page
* Use the "Clone in Desktop" button or:

  $ git clone git@github.com:TheSwanFactory/hourofnode.git
  $ cd hourofnode # or equivalent on windows
  
#### Build and run the project

  $ npm install # Install all required node packages, from package.json
  $ gulp # builds, watches, and launches browser
