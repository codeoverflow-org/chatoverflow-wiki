**Important: Chat Overflow is still work in progress. So this guide will probably change in the future!**

There are 3 important steps when you want to create and implement a new chat overflow plugin:

1. Create a new plugin project with the commands of the framework
2. Implement the pluggable construct
3. Implement the plugin with own logic

## Create a new plugin project

Use the *Create Plugin* configuration or start the custom task `sbt create` directly. Enter the basic plugin information in the command promt. This includes the name, version and base plugin folder (e.g. `plugins-public`). The command creates the folder structure of the new plugin and adds a basic build file. Here you can also add custom dependencies.

Next, run the custom task `sbt fetch` to let the framework look for new plugins and update the plugin reference file `plugins.sbt`. If you're using IntelliJ, you can now reload the framework by hand to register the plugin as new and custom project. You should also run `sbt reload` (Yes, both actions have different effects although they shouldn't).

## Implement the pluggable

Next, add your first class to the source folder of the new plugin. Supported languages are *Scala* and *Java*, but this guide will only show the scala way - development of java plugins is very similar.

The first class should extend the Pluggable-Interface from `org.codeoverflow.chatoverflow.api.plugin.Pluggable`. When the framework starts up, your plugin will be looked trough for a class implementing this interface to get an entry point to your work. A raw version might look like this:

 ```
class MySuperCoolPlug extends Pluggable{

  override def getName: String = ???

  override def getAuthor: String = ???

  override def getDescription: String = ???

  override def getMajorAPIVersion: Int = ???

  override def getMinorAPIVersion: Int = ???

  override def createNewPluginInstance(manager: PluginManager): Plugin = ???
}

 ```

**A short explanation**: The first 3 Methods `getName`, `getAuthor` and `getDescription` are simple: Just a return a String representing the meta information of your plugin. This inclucde it's name (please make sure to not name two plugins develeoped by yourself the same), your name or pseudonym and a brief topic of the plugins purpose.

The next two methods return the number of the API-Version, you developed the plugin with. These are evaluated in the loading process to ensure that your plugin works with the framework version from the user. You can get these numbers from `org.codeoverflow.chatoverflow.api.APIVersion`.

The last method `createNewPluginInstance` is the interesting one: After the framework checked your meta and version information, it will eventually load your plugin completely. In this method (**and only in this method**), you might return an object that extends the plugin interface. This class is will containt your plugin logic.

## Implement the Plugin

The last step is the creation of the plugin class, which contains your own plugin logic. Create a new class and implement the Plugin-Interface, located at `org.codeoverflow.chatoverflow.api.plugin.Plugin`. Alternatively, extend the `PluginImpl` and get rid of some boilerplate code. It might look like this:

```
class MySuperCoolPlugin(manager: PluginManager) extends PluginImpl(manager) {
  override def setup(): Unit = { ... }
  override def loop(): Unit = { ... }
  override def shutdown(): Unit = { ... }
}
```

Let's talk about *Requirements* first: These are the way to retrieve data from the outside world and returning information to it. Basicaly, you can require everything from a single paramter, set by the user to full access to a users livestream chat.

The `getRequirements` method is used by the framework to check what your plugin needs and to ask the user to specify which services or data he wants to give to your plugin. Here is a example:

```
private val require = new Requirements
private val twitchChatInput = require.input.twitchChat("reqTwitch", "A twitch channel", false)
private val nameToSayHelloTo = require.parameter.string("reqHello", "Your name", false)
```

This code requires reading-access to a twitch livestream chat and a parameter ("*a name to say hello to"*). Note: You can obviously not specify, which channel the user might choose - but you can be sure, that you will get a working input. This is ensured by the framework. Please note, that the requirements element already exists, if you extend `PluginImpl`.

After this, the last step ist the `start` method. And it is as easy as you might think: Just add your own logic now, using the required parameters of your Requirement object. Here is a short example: This code will simply print out all messages from a twitch chat in the console. To access the chat, your required variable is used with the `getValue` method.

```
twitchChatInput.getValue.registerMessageHandler(msg => println(msg))
```

Of course, you can also add own classes and infrastrucutre by now - the important steps are done, happy coding!

*One last note: If your testing your plugin the first time, a full reload might be needed. Use the custom task `[Advanced] Full Reload and run ChatOverlfow` to do so. Afters this, you can configure the framework to start your plugin using the [CLI](usage/Using-the-CLI.md)!*