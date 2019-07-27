## Installation
This tutorial shows how to install the chat overflow framework. For now, working with the development environment is the only way. Currently, there are **no builds available.**

<!-- ### Pro

1. Clone the main repository. Then clone the api into folder `codeoverflow/api`, the gui into folder `codeoverflow/gui` and public plugins repository into `codeoverflow/plugins-public`.
2. Setup the main repository as imported scala project, e.g. using IntelliJ. Make sure to refresh all sbt content and load the custom run configurations.
3. You're done. Happy coding! -->

### Step by step guide

0. Install [git](https://git-scm.com/) and [Node.js](https://nodejs.org/en/download/). Make sure to add them to your PATH. To verify the install, open a console and execute `git --version` and `npm --version`. If the version number is echoed back, the installation is valid.
1. Clone the main repository using `git clone https://github.com/codeoverflow-org/chatoverflow.git`.
2. `git` created a folder named `chatoverflow`. Navigate into it using `cd chatoverflow`.
3. Clone the [api repository](https://github.com/codeoverflow-org/chatoverflow-api) into a folder named `api` using `git clone https://github.com/codeoverflow-org/chatoverflow-api.git api`.
4. Clone the [gui repository](https://github.com/codeoverflow-org/chatoverflow-gui) into a folder named `gui` using `git clone https://github.com/codeoverflow-org/chatoverflow-gui.git gui`.
5. Clone the [public plugins repository](https://github.com/codeoverflow-org/chatoverflow-plugins) into a folder named `plugins-public` using `git clone https://github.com/codeoverflow-org/chatoverflow-plugins.git plugins-public`.

    Side note: You can rename the folders to your liking, but if you do change their names, update them in the main [build-file](https://github.com/codeoverflow-org/chatoverflow/blob/42b9469fe489fe5efeb4aa70f278e3558fccab7d/build.sbt#L64).

6. Open your favorite IDE for java and scala development. We recommend using [IntelliJ IDEA](https://www.jetbrains.com/idea/). You can use the free community version as well as the ultimate version.
     
     Side note: The next steps assume that you are using IntelliJ IDEA.
<!-- 7. Make sure, IntelliJ IDEA and the scala plugin are up to date. Every time I open this software, a new update is available... -->
7. If there are any updates to either IntelliJ IDEA or the scala plugin, please install them.
8. Open the cloned `chatoverflow` folder. Make sure that IntelliJ's `auto-import` is NOT enabled.
9. Click on `Refresh sbt project`. Make sure to use a up-to-date java 1.8 SDK and do not change any other settings in the dialog window.
10. Please wait for the process to finish. In the background, 3 projects are built, resources will be downloaded and a lot of magic happens!
11. When the process has finished, you should see the project and its children in IntelliJ's project view. <!--Get to know them (or wait till I introduce them later).-->

     Side note: The run configurations contain a lot of sbt commands and presets for plugin development. You probably will not need more. Brief documentation can be found in the main build.sbt file.

12. Select the run configuration `Fetch plugins (sbt fetch)` and execute it. A file named `plugins.sbt` should be generated, containing all references to plugins and the api project.
13. Use `sbt reload` (the refresh icon in the upper left corner of the sbt window, opened by View -> Tool Windows -> SBT) to reload the whole project. Now, the child projects should have been recognized correctly.
14. Have a look at the application run configurations. Do they have a red X? Then they are broken. Click on `Edit configurations` and select `root` as module ("Use classpath as module"). Now it should work, .
15. Execute the run configuration `[Advanced] Full Reload and Run ChatOverflow`. This is only needed for the first compilation or if you create a new plugin! Those are the steps that are executed now:

     * First, all target folders and the build environment is cleaned.
     * Then the project is built and all plugins are fetched. The `plugins.sbt` file gets generated. After that, the whole build environment gets reloaded.
     * Next, all plugin versions and the api version are printed for debug reasons.
     * Finally, the plugin's compiled code gets packaged into several .JAR-Archives and they get copied into the `plugins`-folder.
     * Everything is set up and the chat overflow framework gets executed. Now the framework tries to load the plugins from the `plugins`-folder. Done!

     <!-- Side note: You do not have to repeat this step after each simple change. There is also a `[Simple]` run configuration for this. -->
     Side note: You must not re-execute this run configuration after you have changed something. Now you can just use the `[Simple]` run configuration.

     Yet another side note: The projects folder structure is really simple.

     * The `api` folder contains the API-project with all common chat overflow modelling.
     * The `plugins` folder contains our packaged plugins. Just leave them alone.
     * The `plugins-public` folder contains all official/public chat overflow plugins. Each plugin has its own sub project.
     * The `project` folder contains build code for the plugin framework.
     * The `src` folder contains the chat overflow framework code.
     * The `target` folder contains the built framework.

16. You're done. Happy coding!