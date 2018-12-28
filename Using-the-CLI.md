There are several possibilites to configure the chat overflow framework. Using the **GUI** is by far the easiest way. Beside this, you can also configure everything using the **configuration xml file** - it's easier than you might think. The third option is using the **command line interface** and the **REPL** (As of commit [6f1c1a1](https://github.com/codeoverflow-org/chatoverflow/commit/6f1c1a1a58241997debf9993e11543404e75eb7e)).

## Command Line Interface

This messages shows up when you execute the framework with the flag `--help`:

```
Chat Overflow 1.0
Usage: Chat Overflow [options]

  -u, --userInterface <value>
                           select the ui to launch after initialization. Possible values are: GUI, REPL.
  -p, --pluginFolder <value>
                           path to a folder with packaged plugin jar files
  -c, --configFolder <value>
                           path to the folder to save configs and credentials
  -r, --requirementPackage <value>
                           path to the package where all requirements are defined

For more information, please visit http://codeoverflow.org/
```

## REPL

The REPL is available at every time on the console. You can use this beside the gui to have control over every element of the framework.

These commands are available (Use the command `help` to see this message):

```
entry:	Adds a credentials entry to a existing placeholder.
run:	Starts a plugin instance. Make sure to configure everything other first!
instance:	Adds a new plugin instance.
quit:	Quits the chat overflow framework, too!
requirement:	Adds a requirement to a already existing plugin instance.
help:	Prints all available commands.
connector:	Adds a new connector.
exit:	Quits the chat overflow framework.
start:	Starts a plugin instance. Make sure to configure everything other first!
save:	Saves the current state (credentials and configs) of the framework.
credentials:	Adds a credentials placeholder for a connector.
list:	Lists all registered plugin instances.
```

 ## Important value types

There are several important infos about the repl.
- Connector and credential types are full type strings, e.g. `org.codeoverflow.chatoverflow.requirement.service.twitch.chat.TwitchChatConnector`
- Requirements are full type strings, e.g. `org.codeoverflow.chatoverflow.api.io.input.chat.TwitchChatInput`
- Some credential values have special rules. E.g. oauth keys may have to start with `oauth:`

## Configuration

You can also configure the paths of config- and credentials-files to create custom setups:

```
-c customConfig/ -p customPlugins/
```

*Please notice: Added credentials are encrypted with AES 128.*