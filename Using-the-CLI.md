There are several possibilites to configure the chat overflow framework. Using the **GUI** is by far the easiest way. Beside this, you can also configure everything using the **configuration xml file** - it's easier than you might think. The third option is using the **command line interface** and the **REPL** (As of commit [6f1c1a1](https://github.com/codeoverflow-org/chatoverflow/commit/6f1c1a1a58241997debf9993e11543404e75eb7e)).

## Command Line Interface

This messages shows up when you execute the framework with the flag `--help`:

```
Chat Overflow
Usage: Chat Overflow [options]

  -u, --userInterface <value>
                           select the ui to launch after initialization. Possible values are: GUI, REPL.
  -p, --pluginFolder <value>
                           path to a folder with packaged plugin jar files
  -c, --configFile <value>
                           path to a custom config xml file
  -d, --credentialsFile <value>
                           path to a custom credentials xml file

For more information, please visit http://codeoverflow.org/
```

## REPL

The REPL is available at every time on the console. You can use this beside the gui to have control over every element of the framework.

These commands are available (Use the command `help` to see this message):

```
entry:		Adds a credentials entry to a existing placeholder. RESTART REQUIRED.
run:		Runs a plugin. Make sure to configure everything other first!
instance:	Adds a new plugin instance. RESTART REQUIRED.
quit:		Quits the chat overflow framework, too!
requirement:	Adds a requirement to a already existing plugin instance. RESTART REQUIRED.
help:		Prints all available commands.
connector:	Adds a new connector. RESTART REQUIRED.
exit:		Quits the chat overflow framework.
start:		Runs a plugin. Make sure to configure everything other first!
credentials:	Adds a credentials placeholder for a connector.
```

 ## Important value types

There are several important infos about the repl.
- Connector and credential types are full type strings, e.g. `org.codeoverflow.chatoverflow.service.twitch.chat.TwitchChatConnector`
- Requirements are full type strings, e.g. `org.codeoverflow.chatoverflow.api.io.input.chat.TwitchChatInput`
- Some credential values have special rules. E.g. oauth keys may have to start with `oauth:`

## Configuration

You can also configure the paths of config- and credentials-files to create custom setups:

```
-c config/myconfigfile2.xml -d config/mynewcredentials
```

*Please notice: Added credentials are encrypted with AES 128.*