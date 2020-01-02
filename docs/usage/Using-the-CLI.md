Chat overflow may be configured using the CLI. While running, the easiest way to control everything is the [**Better REPL**](/docs/usage/Using-the-GUI.md), accessible through `http://localhost:2400`.

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
  -f, --enableLogFile      set this flag to enable logging to log files

For more information, please visit http://codeoverflow.org/
```
> ## Attention:
> ### Currently there is a bug that prevents custom web server ports from working properly.
> ### See [#149](https://github.com/codeoverflow-org/chatoverflow/issues/149).

## Configuration

You can also configure the paths of config- and credentials-files to create custom setups:

```shell
-c customConfigFolder -p customPluginFolder
```

The combination of logging in and starting plugins with one command is very useful for rapid prototyping.

```shell
-l myPassword -s startupPluginInstance1,startupPluginInstance2
```

By default the log output of a plugin on the console is disabled. You can enable it with the flag `-o`.
