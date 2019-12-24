Chat Overflow has two different kinds of deployments: a end-user deployment that is only able to run plugins and a plugin developer deployment that can also be used to create plugins. These deployments are usually generated and published to the world when a new version of Chat Overflow is released.

Once a release is published these deployments should automatically be created and uploaded to the release by a GitHub action, but in case you want to share a deployment of a current development version or the action is failing you can follow the instructions in this article.

## End-User Deployment

To create a deployment for end-users that only want to run plugins and use the framework follow these steps:

1. Execute the IntelliJ run configuration `[Deploy] Generate Bootstrap Launcher and deploy` or run the make target with `make bootstrap_deploy`. This bundles everything and copies it along with start scripts, the license and a readme to the `deploy`-folder. Magic.
2. Create a zip archive of the `deploy` directory, don't include any runtime generated files. 
3. Test that the deployment works correctly by starting it and testing functionality.
4. Distribute the zip file.

The `deploy`-folder contains the bootstrap launcher that can be started with the start scripts or with `java -jar ChatOverflow.jar`. It then downloads all required libraries, which are specified in the `dependencies.pom` file that is included in the jar file of the framework, to the local cache using [Coursier](https://get-coursier.io) and starts Chat Overflow.

The folder-structure of the end-user deployment is as follows:

```
deploy/
├──bin/                      Jars of the API, the framework and the GUI
├──ChatOverflow.jar          Fat-Jar of the bootstrap launcher
├──ChatOverflow.*            Start scripts for various platforms
├──LICENSE                   EPL-2.0 license
└──README.html               A readme with starter information
```

If the framework has been started once it will create directories for config files, data files of plugins and plugin jars. These directories and their contents are *NOT* to be included in the deployment zip file.

## Plugin Developer Deployment

To create a deployment for plugin dev that not only want to run plugin, but also want to develop them follow these steps:

1. Execute the IntelliJ run configuration `[DeployDev] Deploy Plugin Dev Environment` or use make to create the deployment by executing `make bootstrap_deploy_dev`.
2. Create a zip archive of the `deployDev` directory, don't include any files that are generated during runtime.
3. Test that the deployment works correctly by starting it and testing functionality.
4. Distribute the zip file.

A plugin developer deployment contains the framework and the GUI in jars, the api in form of source code and sbt scripts (e.g. create and fetch) to be able to create and compile plugins.

The folder-structure of the plugin-dev deployment is as follows:

```
deployDev/
├──.idea/                    IntelliJ run configurations
├──api/                      The api project in source code
├──bin/                      Jars of the framework and the GUI
├──project/                  Contains a jar of the chatoverflow-build code
├──build.sbt                 Main sbt file, contains general settings and task definitons
├──dependencies.sbt          Imports all dependencies of the framework
└──LICENSE                   EPL-2.0 license
```

