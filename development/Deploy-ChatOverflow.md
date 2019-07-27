To deploy Chat Overflow and create runnable jar files, follow these steps:

1. Execute the IntelliJ run configuration `[Deploy] Generate Bootstrap Launcher and deploy` or run the make target with `make bootstrap_deploy`. This updates the `dependencies.xml`-file in the bootstrap-project with the current dependencies, bundles everything and copies it along with start scripts, the license and a readme to the `deploy`-folder. Magic.
2. Navigate to the `deploy`-folder and run the bootstrap launcher with `java -jar ChatOverflow.jar`. After downloading all libraries, a standalone version of Chat Overflow should be started.

A release of chat overflow is simply a zip archive of the deploy folder, without configs or libraries. Don't forget to update Chat Overflow Framework and API Version before a public release.