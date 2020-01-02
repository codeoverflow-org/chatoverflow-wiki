Thank you for improving *Chat Overflow*.  
While plugins live in their own project, source connections (e.g. to a platform like Twitch or Discord) exist in the framework itself.  
<!-- By this measure, we can make sure that everyone profits from the same features.   -->
We made this design choice so that all platform source connectors are free to access by all plugin developers.
This wiki entry tries to show you the different steps needed to implement a new connection.

1. Add new types to the API (Also register them in the requirement Input/Output section)
2. Create a new package in the framework services package and implement the source specific connector
3. Create a impl package and implement the types you have added in the API
4. Enhance your connector with metadata

## Add new types to the API

Add all needed data transfer objects in `org.codeoverflow.chatoverflow.api.io.dto` and interfaces representing input / output to the correct API package. E.g., a chat input belongs to `org.codeoverflow.chatoverflow.api.io.input.chat` and should extend `ChatInput`.

We require you to also register your new type in the corresponding requirement class located in `org.codeoverflow.chatoverflow.api.plugin.configuration`. Yes, this step could be automated by using reflection, but by providing a clean interface to the plugin developer we protect type safety.

## Add a new package and connector

Create a new package inside the service package of the framework: `org.codeoverflow.chatoverflow.requirement.service`. Next, implement a connector that extends `org.codeoverflow.chatoverflow.connector.Connector` which takes login data and creates a connection to the new platform.  
Use the lists `requiredCredentialKeys` and `optionalCredentialKeys` to set what login data you need and the credentials object to get the actual data.  
Implement the code that sets up the connection in the `start()` method and the code that closes the connection on shutdown in `stop()`.  
For logging use the logger provided by the `WithLogger` trait.  
A very basic example is the `org.codeoverflow.chatoverflow.requirement.service.sample.SampleConnector`.
Just use the helper impl classes `InputImpl` and `OutputImpl`

With this connector, you can now implement the interfaces you just added to the API. E.g.

```scala tab=
@Impl(impl = classOf[SampleInput], connector = classOf[SampleConnector])
class SampleInputImpl extends InputImpl[SampleConnector] with SampleInput with WithLogger {

  override def start(): Boolean = ...

  override def stop(): Boolean = ...
}
```

!!! important
    
    **The @Impl-annotation will guide the framework to load your new connector and types.**

## Metadata

To guide the user while adding new connectors / platform sources, we ask you to provide some metadata for your connector.

Create a XML-file with the full name of your connector type, e.g. `org.codeoverflow.chatoverflow.requirement.service.discord.discordchatconnector.xml` inside the `main/resources/connector`-folder of the project. This file should contain the following information:

!!! example
    
    ```xml
    <connector>
        <display>The Display Name</display>
        <description>A short description</description>
        <wiki>A link to the corresponding wiki entry</wiki>
        <icon48>
          a base64 encoded 48x48 png file
        </icon48>
    </connector>
    ```

!!! note 
    
    This step is optional, but highly recommended.
