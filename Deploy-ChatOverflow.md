To deploy Chat Overflow and create runnable jar files, follow these steps:

1. Execute `sbt dependencyList` to get a dependency list of the current framework version on the console
2. Copy the output into the `dependencyList.txt`-file. Only copy the lines with dependency information (see commited example)
3. Execute the run configuration `[Deploy] Generate Bootstrap Launcher and deploy`. This updates the `dependencies.xml`-file in the bootstrap-project, bundles everything and copies it to the `deploy`-folder. Magic.
4. Navigate to the `deploy`-folder and run the bootstrap launcher with `java -jar ChatOverflow.jar`. After downloading all libraries, a standalone version of Chat Overflow should be started.

A release of chat overflow is simply the deploy folder, without configs or libraries. Don't forget to update Chat Overflow Framework and API Version before a public release.