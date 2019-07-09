Thank you for help for the development of *Chat Overflow*.  
While plugins live in their own project, source connections (e.g. to platform like Twitch or Discord) exist in the framework itself.  
By this, we can make sure that everyone profits from the new possibilites.  
This wiki entry tries to show you the different steps needed to implement a new connection.

1. Add new types to the API (Also register them in the requirement Input/Output section)
2. Create a new package in the framework services package and implement the source specific connector
3. Create a impl package and implement the types you added in the API

## Add new types to the API

Add all needed data transfer objects in `org.codeoverflow.chatoverflow.api.io.dto` and interfaces representing input / output to the correct API package. E.g. a chat input belongs to `org.codeoverflow.chatoverflow.api.io.input.chat` and should extend `ChatInput`.

We require you to also register your new type in the corresponding requirement class located in `org.codeoverflow.chatoverflow.api.plugin.configuration`. Yes, this step could be automated by using reflection. But by providing a clean interface to the plugin developer we protect type safety.

## Add a new package and connector

Create a new package inside the service package of the framework: `org.codeoverflow.chatoverflow.requirement.service`. Next, implement a connector that extends `org.codeoverflow.chatoverflow.connector.Connector` which takes login data and creates a connection to the new platform.  
Use the lists `requiredCredentialKeys` and `optionalCredentialKeys` to set what login data you need and the credentials object to get the actual data.  
Implement the code that sets up the connection in the `start()` method and the code that closes the connection on shutdown in `stop()`.  
For logging use the logger provided by the `WithLogger` trait.  
A very basic example is the `org.codeoverflow.chatoverflow.requirement.service.sample.SampleConnector`.
Just use the helper impl classes `InputImpl` and `OutputImpl`

With this connector, you can now implement the interfaces you just added to the API. E.g.

```
@Impl(impl = classOf[SampleInput], connector = classOf[SampleConnector])
class SampleInputImpl extends InputImpl[SampleConnector] with SampleInput with WithLogger {

  override def start(): Boolean = ...

  override def stop(): Boolean = ...
}
```

**Important:** The @Impl-annotation will guide the framework to load your new connector and types.