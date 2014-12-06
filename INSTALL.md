### Installation Instructions ###

The Hour of Node web application can be accessed and used online (http://hourofnode.org) or it can be locally installed on a system.  

**Document's Purpose**
This document explains the steps necessary for downloading, installing, configuring, and running The Hour of Node web-application locally.

**Why install it locally?**
Installing the web-app locally (as opposed to using it from hourofnode.org) allows you to make customized changes to the web-app and to design your own games via game description files.

So ... let's get the installation process started.

**Supported Operating Systems**
Any operating system that git, node.js, npm, and CoffeeScript supports should work for The Hour of Node project; as a locally installed web-application.  Such common operating systems are:

  * Apple OS X
  * Linux - Ubuntu, RedHat, Debian, etc.
  * Microsoft Windows

**Required Software/Modules**
(for administering The Hour of Node web-app)

  * git
  * node.js
  * npm
    * gulp
    * CoffeeScript
    * Reactive-Coffee
    * underscore.js

** Notes **
  *  npm is now included with node.js' installer; installing node.js should install and configure npm on your system.
  *  Items under npm are modules  installed with the `npm` command:
```  
     npm -install [module name]
```

### Installation Steps (Prerequisite Software/Utilties) ###

1.) Install Git
  Download it from here: http://git-scm.com/downloads

2.) Install node.js
  Download it from here: http://nodejs.org/download/
*Note*: MS Windows installs: a reboot of the system is required, after installing node.js, for *npm* to be accessible via the CMD prompt. 

### Installation Steps (The Hour of Node web-app) ###
3.) Download and install The Hour of Node project
We recommend doing this as a Git clone:
```
--> git clone https://github.com/TheSwanFactory/hourofnode.git
```
4.) Launch a terminal

  * Mac OS: Utilities
  * Windows: CMD Prompt or CYGWIN

The following steps will be done inside the terminal/CMD prompt ...
5.) Install npm
```
--> npm install
```
6.) Install gulp
```
--> npm -g install gulp
```
### Launching The Hour of Node web-app ###
In the terminal (or Windows CMD prompt):
1.) Change directory to the top directory where The Hour of Node resides

  * (i.e. Unix: /opt/hourofnode)
  * (i.e. Windows: C:\temp\hourofnode)

2.) Type the command: gulp
```
    --> gulp
```
A successful start-up of The Hour of Node web-app should result in lines similar to these (in the terminal):
```
    [20:09:00] Requiring external module coffee-script/register
    [20:09:04] Using gulpfile c:\Temp\hourofnode\gulpfile.coffee
    [20:09:04] Starting 'main'...
    [20:09:04] Starting 'sync'...
    [20:09:04] Finished 'sync' after 67 ms
    [20:09:04] Starting 'watch'...
    [20:09:04] Finished 'watch' after 55 ms
    [BS] Local URL: http://localhost:3000
    [BS] Serving files from: web
    [BS] Watching files...
    [BS] File changed: c:\Temp\hourofnode\web\main.js
    [20:09:06] Finished 'main' after 2.57 s
    [20:09:06] Starting 'default'...
    [20:09:06] Finished 'default' after 8.55 µs
```
And a web browser should pop-up displaying the local instance of The Hour of Node web-app.

The web-app is automatically served-up at:
`http://localhost:3000`


### Wrapping Up - And Other Useful Info###
Microsoft Windows - Detailed Instructions
For **detailed instructions** of installing The Hour of Node web-app on **Microsoft Windows** systems please see this document:  ##TODO - include link to document out on the WordPress site##


For further information, be sure to checkout our various websites:

  * http://hourofnode.org
  * http://theswanfactory.wordpress.com
  * https://www.facebook.com/HourOfNode
  * https://twitter.com/theswanfactory
  * https://www.youtube.com/user/AwesomeStuffBadly
  * https://github.com/TheSwanFactory
  * https://github.com/TheSwanFactory/hourofnode<


## Happy Hour-of-Noding :-) ##
