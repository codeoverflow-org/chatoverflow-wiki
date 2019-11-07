The GUI for chatoverflow is still in development.  
That's why we have the **Better REPL**, an easy-to-use one-page dashboard, where everything can be controlled.

## Starting the Better REPL
When using the GUI for the first time use the `[Advanced]` run configuration that packages the gui. Make sure to reload sbt afterwards to make IntelliJ find and load the gui.

For all further runs you may use the `[Simple]` run configuration which is way faster.  

Once the framework is running open http://localhost:2400/ in a browser and wait for the server status to display `Connected!`. Now click on `OPEN BETTER REPL`. 

![](/img/usage/login.png)

When running for the first time enter a password that you want to use for securing your credentials and click on `REGISTER`.  
If you are already registered, use your password to login.  
If the login was successful the gui will display the authentication key for this session.  

## Creating a plugin instance
Before running a plugin you have to create a plugin instance.  
All available plugins are listed under `Plugin types`.  
Add more plugins by putting the plugin `.jar` files into the plugins folder. If you are adding new plugins to the folder while the framework is still running, you need to restart the framework in order for it to load the newly added plugins.

![](/img/usage/plugin-types.png)

Enter the plugin and author name of the plugin and give the instance a name (whatever you like), then click on `CREATE`: 

![](/img/usage/create-plugin.png)

The plugin instance should now be listed under `Plugin instances`: 

![](/img/usage/plugin-instances.png)

You can use the pen to copy the name of an instance.  
There are buttons that allow you to `START` / `STOP` an instance, to show its log (if running) or requirements and a button to `DELETE` the instance (just make sure to stop it before deleting it).

## Setting plugin requirements
Before you can start a plugin you need to set its requirements.
A plugin can require a lot of things, for example Strings, Inputs or Outputs.
To view all requirements of a plugin enter the instance name and click on `SHOW REQUIREMENTS`.  

![](/img/usage/plugin-requirements.png)
You see that each requirement has a type and needs a value.  
You see which requirements are already set and which ones are optional.  
To set or change the value click on the blue pen, enter the required value and click on `PUT`.  

![](/img/usage/change-requirement.png)

For inputs and outputs the value should be the source identifier of a connector - which you first have to define.

## Adding connectors
To add a connector use whatever source identifier you like, specify the connector type (a list of all types can be found in the connector types box above) and click `ADD`.  It will then be displayed in the list on the left side.  

![](/img/usage/create-connector.png)

## Set credentials
Every connector requires you to set the credentials for that service.  
Use the blue pen to copy the identifier and the type to the connector and then use the manage credentials field to set key and value of the credentials.

![](/img/usage/credentials.png)

Currently the only way to view which credentials a connector requires is to click on `GET` in the manage credentials section and have a look at the returned response which is displayed in the Last request section. It should look similar to this:
```json
{"found":true,"sourceIdentifier":"twitch","uniqueTypeString":"org.codeoverflow.chatoverflow.requirement.service.twitch.chat.TwitchChatConnector","areCredentialsSet":true,"isRunning":false,"requiredCredentialKeys":["oauth"],"optionalCredentialKeys":[]}
```
Look for `requiredCredentialKeys` and `optionalCredentialKeys`.

If you are getting errors when adding credentials [Frequent-Issues](Frequent-Issues.md#Credentials-value-encrypted-with-wrong-auth-key) might contain a solution.

*Please note: Added credentials are encrypted with AES 128/256. The password is not stored anywhere. If you loose your password, there will be no way to reuse your configured and saved credentials.*

