Chat Overflow has two different kinds of deployments: a end-user deployment that is only able to run plugins and a plugin developer deployment that can also be used to create plugins. These deployments are usually generated and published to the world when a new release of Chat Overflow is released.

## End-User Deployment

To create a deployment for end-users that only want to run plugins and use the framework follow these steps:

1. Execute the IntelliJ run configuration `[Deploy] Generate Bootstrap Launcher and deploy` or run the make target with `make bootstrap_deploy`. This updates the `dependencies.xml`-file in the bootstrap-project with the current dependencies, bundles everything and copies it along with start scripts, the license and a readme to the `deploy`-folder. Magic.
2. Create a zip archive of the `deploy` directory. 

The `deploy`-folder contains the bootstrap launcher that can be started with the start scripts or with `java -jar ChatOverflow.jar`. It then downloads all required libraries into the `lib`-folder and starts Chat Overflow.

The folder-structure of the end-user deployment is as follows:

```
deploy/
├──bin/                      Jars of the API, the framework and the GUI
├──ChatOverflow.jar          Far-Jar of the bootstrap launcher
├──ChatOverflow.*            Start scripts for various platforms
├──LICENSE                   EPL-2.0 license
└──README.html               A readme with starter information
```

If the bootstrap launcher and framework have been started once they will create directories for the required libraries, config files, data files of plugins and plugin jars. These directories and their contents are *NOT* to be included in the deployment zip file.

## Plugin Developer Deployment

To create a deployment for plugin dev that not only want to run plugin, but also want to develop them follow these steps:

1. Execute the IntelliJ run configuration `[DeployDev] Deploy Plugin Dev Environment` or use make to create the deployment by executing `make bootstrap_deploy_dev`.
2. Create a zip archive of the `deployDev` directory.

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

