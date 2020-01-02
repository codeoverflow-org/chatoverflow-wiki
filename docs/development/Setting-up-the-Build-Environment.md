This short tutorial is meant for developers and shows how to setup the build environment.  
If you want to install and run ChatOverflow head over to [Installation](/docs/usage/Installation.md).

## Prerequisites

For working on chatoverflow the following tools must be installed on your PC:

* Java 8 version `1.8.0_161` or newer
* [git - version control system](https://git-scm.com/downloads) 
* [sbt - Scala build tool](https://www.scala-sbt.org/download.html)
* [yarn](https://yarnpkg.com/) or [npm](https://www.npmjs.com/get-npm)  - package manager

## Windows

1. Save the [📄 install.bat](https://raw.githubusercontent.com/codeoverflow-org/chatoverflow-setup/master/install.bat) to the directory where you want to install the build environment.

2. Execute the script, use the `--dev` argument if you want to check out the development branch automatically.
   If you want to do an advanced build directly after the installation use the `--build` flag.

3. Drink some coffee while the script clones all repositories, sets up sbt and installs the gui.

4. Start developing!

## UNIX operating systems (MacOs / Linux)

1. Save the [📄 install.sh](https://raw.githubusercontent.com/codeoverflow-org/chatoverflow-setup/master/install.sh) to the directory where you want to install the build environment.

2. Execute the script, use the `--dev` argument if you want to check out the development branch automatically.
   If you want to do an advanced build directly after the installation use the `--build` flag.

3. Drink some coffee while the script clones all repositories, sets up sbt and installs the gui.

4. Start developing!

### Alternative

This command downloads the script and executes it:  
```shell script
bash <(curl -s https://raw.githubusercontent.com/codeoverflow-org/chatoverflow-setup/master/install.sh)
```
