There are several possibilites to configure the chat overflow framework. Using the **GUI** is by far the easiest way. Beside this, you can also configure everything using the **configuration xml file** - it's easier than you might think. The third option is using the **command line interface**.

## Documentation

This messages shows up when you execute the framework with the flag `--help`:

```
Usage: Chat Overflow [addInstance|addConnector|addCredentials|addCredentialsEntry|addRequirement|runPlugins] [options]

  -p, --pluginFolder <value>
                           path to a folder with packaged plugin jar files
  -c, --configFile <value>
                           path to a custom config xml file
  -d, --credentialsFile <value>
                           path to a custom credentials xml file

Command: addInstance [options]
Adds a plugin instance. Restart required.
  -i, --instanceName <value>
                           the name of the instance to create
  -n, --pluginName <value>
                           the name of the plugin to instantiate
  -a, --pluginAuthor <value>
                           the author of the plugin to instantiate

Command: addConnector [options]
Adds a connector. Restart required.
  -t, --connectorType <value>
                           the type string of the connector (from the api)
  -i, --connectorId <value>
                           the source name for the connection

Command: addCredentials [options]
Adds a credentials placeholder. Will probably need entries to work correctly.
  -t, --credentialsType <value>
                           the type string of the credentials (same as the connector)
  -i, --credentialsId <value>
                           the source id of the credentials (same as the connector)

Command: addCredentialsEntry [options]
Adds a credentials entry to a existing placeholder. Restart required.
  -t, --credentialsType <value>
                           the type string of the credentials (same as the connector)
  -i, --credentialsId <value>
                           the source id of the credentials (same as the connector)
  -k, --credentialsKey <value>
                           specifies the key of the credentials entry
  -v, --credentialsValue <value>
                           the value to set in the registered credentials

Command: addRequirement [options]
Adds a requirement to a already existing plugin instance. Restart required.
  -i, --instanceName <value>
                           the name of the instance to set a requirement
  -k, --requirementId <value>
                           the id of the requirement. has to be plugin unique
  -t, --targetType <value>
                           the target type of the requirement, e.g. which source
  -c, --content <value>    the serialized content of that requirement

Command: runPlugins [options]
Run the specified, command separated plugin instances. Remember to add connectors, credentials and requirements first.
  -p, --plugins <value>    the instance names of all plugins, comma separated

For more information, please visit http://codeoverflow.org/
```



 ## Examples

Here are some examples, how to use the different commands. *Important: The types have to be the qualified type strings of the framework classes.*

```
addInstance -n PluginName -a PluginAuthor -i InstanceName
addConnector -t org.codeoverflow...TwitchConnector -i skate702
addCredentials -t org.codeoverflow...TwitchConnector -i skate702
addCredentialsEntry -t org... -i skate702 -k oauth -v oauth:xxx
addRequirement -i InstanceName -k ReqId -t TwitchChatInput -c skate702
runPlugins -p InstanceName
```

**Short explanation:** This arguments add a new instance from an already loaded plugin. After this, a connector is linked with a credentials entry. At the end, a requirement for the instanciated plugin is filled with a chat input, then, the plugin instance is executed.

You can also configure the paths of config- and credentials-files to create custom setups:

```
-c config/myconfigfile2.xml -d config/mynewcredentials
```

*Please notice: Added credentials are encrypted with AES 128.*