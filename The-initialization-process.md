This wiki page is supposed to explain the initialization mechanism of Chat Overflow. This knowledge is important, if you want to help the chat overflow framework development yourself. *Please note: Chat Overflow is still work in progress. This might and will change!*

## Overview

By now, the framework initialization contains 6 different steps. Step 1-4 are executed before the evaluation of CLI commands, steps 5 and 6 are evaluated later.

1. Loading the framework and plugins
2. Loading the framework configuration
3. Loading the plugin instances
4. Loading the credentials
5. Loading and initializing connectors
6. Loading plugin requirements

## Loading the framework and plugins

The first step is the plugin framework initialization. This inculdes:

- Looking into the `plugins` folder and searching for *.jar-Files*
- The creation of a custom class loader with a custom security policy
- Loading the *.jar-Files* and scanning for pluggalbe objects
- Checking the plugins configuration

When the framework is initialized, all external plugins which are considered functional, are loaded and listed.

## Loading the framework configuration

The next step is quite simple: The configuration file, usually located at `config/config.xml` , is loaded and all serialized configuration data is checked. This includes:

- Plugin instances with custom user configuration and requirements
- Registered connectors (the users platform connections)

## Loading the plugin instances

This informations are now used to load the plugin instances. In this step, already loaded plugins are instatiated at users wish. By now, an instance contains the following information:

- The plugins author and name
- The unique name of the instance
- A list of requirements used later

E.g. the user created an instance named `TwitchChatLogger` which uses the super cool plugin `ChatLogger` from the author `minzigerDude42`, linked to the users twitch channel.

## Loading the credentials

Next, the credentials are loaded. This includes asking the user for a password. The credentials are encrypted using AES with Cipher Block Chaining and a 128-bit key length. Credentials include key-value sets for registered connectors. Connectors and Credentials are linked by type and unique IDs.

## Loading and initializing connectors

With the loaded credentials, the connectors are now instantiated. This is done by dynamicaly creating a connector instance with the given type from the configuration file. After this step, the matching credentials are used to create a connection to the connectors platform.

*Note: Before this step, several CLI commands are evaluated to ensure that configs can be set before used. Without correct configuration, the loading mechanism might fail.*

## Loading plugin requirements

The last step is the loading process of all plugin requirements. This process is not trivial:

- From the config, the requirement type from the API definition is retrieved, e.g. `org.codeoverflow.chatoverflow.api.io.input.chat.TwitchChatInput`
- This type string is used to determine the concrete type string and a method to instantiate the requirement. This might seem a little bit overcomplicated, but this is way more type safe than creating everything dynamically.
- This does also include the linking process with a previously created connector from the configuration data. Because of late initialization, the platform connection is build when first used.
- This step is repeated for every requirement and for every plugin.

And that's it! After this step, every plugin is connected to its required sources using the connectors and their credentials.