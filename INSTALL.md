### Installation Instructions ###

The Hour of Node web application can be accessed and used online (http://hourofnode.org) or it can be locally installed on a system.  

**Document's Purpose**
This document explains the steps necessary for downloading, installing, configuring, and running The Hour of Node web-application locally.

**Why install it locally?**
Installing the web-app locally (as opposed to using it from hourofnode.org) allows you to make customized changes to the web-app and to design your own games via game description files.

So ... let's get the installation process started.  We also have more detailed instructions available for [installing on Microsoft Windows](http://theswanfactory.com/2014/12/06/installation-instructions-ms-windows/).

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
  Download it from here: http://nodejs.org/en/download/
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
7.) Install CoffeeScript [##TODO: Investigate this step - don't think this has to be done]
```
--> npm -g install coffee-script
```
8.) Install Reactive-Coffee  [##TODO: This step is under question - will investigate]
```
--> npm -g install reactive-coffee
```
9.) Install jQuery
```
--> npm -g install jquery
```
10.) Install the 'underscore' module
```
--> npm install underscore
```

11.) You **may** need to download and unzip reactive-coffee from here:

http://yang.github.io/reactive-coffee

Either click the ".zip file" link (Windows), or click the ".tar.gz file" (Apple OS/UNIX) link

Unzip the zipped file's contents into the parent directory that contains The Hour of Node's install directory.  

** Unix Example: **

If The Hour of Node web-app was unzipped into /opt/hourofnode
Then reactive-coffee's tar.gz file's contents should be gunzipped into: /opt/reactive-coffee

** Windows Example: **

If The Hour of Node web-app was unzipped into C:\temp\hourofnode
Then reactive-coffee's .zip file's contents should be unzipped into: C:\temp\reactive-coffee

12.) npm packages **may** need to be updated - try doing this if errors occur when attempting to serve-up The Hour of Node web-app with 'gulp' 
```
--> npm update
```

### Launching The Hour of Node web-app ###
In the terminal (or Windows CMD prompt):
1.) Change directory to the top directory where The Hour of Node resides

  * (i.e. Unix: /opt/hourofnode)
  * (i.e. Windows: C:\temp\hourofnode)

2.) Type the command: gulp
```
    --> gulp &
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

TODO: 
  - On UNIX this will run Gulp in the background
  - Need a way to do that on Windows

### Wrapping Up - And Other Useful Info###
Microsoft Windows - Detailed Instructions
For **detailed instructions** of installing The Hour of Node web-app on **Microsoft Windows** systems please see this document:  ##TODO - include link to document out on the WordPress site##

User's Guide
The Hour of Node User's Guide can be found here:
  ##TODO - include link to the User's Guide document##

For further information, be sure to checkout our various websites:

  * http://hourofnode.org
  * http://theswanfactory.wordpress.com
  * https://www.facebook.com/HourOfNode
  * https://twitter.com/theswanfactory
  * https://www.youtube.com/user/AwesomeStuffBadly
  * https://github.com/TheSwanFactory
  * https://github.com/TheSwanFactory/hourofnode<


## Happy Hour-of-Noding :-) ##
