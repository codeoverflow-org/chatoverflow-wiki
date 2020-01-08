If you have updated from prealpha 2 to prealpha 3 you might notice that your plugins aren't detected by the framework anymore and are also not included in `plugins.sbt` by the sbt fetch task.

This is because as of 3.0.0-prealpha `Pluggable` got removed and replaced with a xml file called `plugin.xml` in the resources of the plugin. Check the issue at [codeoverflow-org/chatoverflow#41](https://github.com/codeoverflow-org/chatoverflow/issues/41) or the pr at [codeoverflow-org/chatoverflow#91](https://github.com/codeoverflow-org/chatoverflow/pull/91) for more information about this rework.

Here are the required steps to make your plugin compatible with the new format:

1. Delete your class implementing `Pluggable`. Its not used anymore and got removed from the api.

2. Create the resources directory at `yourPlugin/src/main/resources`.

3. Create a file at `yourPlugin/src/main/resources/plugin.xml` containing the following: 

    !!! example 
        ```xml
        <plugin>
            <name>myPluginName</name>
            <author>sebinside</author>
            <description>This is a simple plugin for demonstration purposes.</description>
            <api>
                <major>3</major>
                <minor>0</minor>
            </api>
            <version>0.3.0</version>
            <website>https://codeoverflow.org</website>
            <sourceRepo>https://github.com/codeoverflow-org/chatoverflow-plugins</sourceRepo>
            <bugtracker>https://github.com/codeoverflow-org/chatoverflow/issues</bugtracker>
            <license>EPL-2.0</license>
        </plugin>
        ```

4. Replace these values with yours. Name, author, api and version are mandatory while the other ones aren't and can be omitted by remove the xml tag. Note that you also may need to adjust the api version numbers if you are running a newer version.

