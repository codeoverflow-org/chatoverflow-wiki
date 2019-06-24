Chat overflow may be configured using the CLI. While running, the easiest way to control everything is the **GUI**, accessible through `http://localhost:2400`.

## Command Line Interface

This messages shows up when you execute the framework with the flag `--help`:

```
Chat Overflow x.x
Usage: Chat Overflow [options]

  -p, --pluginFolder <value>
                           path to a folder with packaged plugin jar files
  -c, --configFolder <value>
                           path to the folder to save configs and credentials
  -r, --requirementPackage <value>
                           path to the package where all requirements are defined
  -l, --login <value>      the password to login to chat overflow on framework startup
  -s, --start <value>      a comma-separated list of plugin instances to start after login (has to be combined with -l)
  -d, --pluginDataFolder <value>
                           path to the data folder, accessible from within plugins
  -w, --webServerPort <value>
                           default web server port, used eg. for the rest api and web gui
  -o, --enablePluginOutput
                           set this flag to enable plugin log output on console

For more information, please visit http://codeoverflow.org/
```

## Configuration

You can also configure the paths of config- and credentials-files to create custom setups:

```
-c customConfigFolder -p customPluginFolder
```

Useful is the combination of login and startup plugins for rapid prototyping.

```
-l myPassword -s startupPluginInstance1,startupPluginInstance2
```

By default, plugin output on console is disable. But you can still enable it with the flag `-o`.

## GUI

The GUI is still in development. The **Better REPL** is an easy-to-use one-page dashboard, where everything can be controlled.

*Please note: Added credentials are encrypted with AES 128/256.*