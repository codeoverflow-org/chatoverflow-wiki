Thank you for help for the development of *Chat Overflow*. While plugins live in their own project, source connections (e.g. to platform like Twitch or Discord) exist in the framework itself. By this, we can make sure that everyone profits from the new possibilites. This wiki entry tries to show you the different steps needed to implement a new connection.

1. Add new types to the API
2. Create a new package in the framework services package and implement the source specific connector
3. Create a impl package and implement the types you added in the API

## Add new types to the API

Add all needed base types and interfaces representing input / output to the correct API package. E.g. a chat input belongs to `org.codeoverflow.chatoverflow.api.io.input.chat` and should extend `ChatInput`. 

## Add a new package and connector

Create a new package inside the service package of the framework: `org.codeoverflow.chatoverflow.requirement.service`. Next, implement a connector which takes login data and creates a connection to the new platform.

With this connector, you can now implement the interfaces you just added to the API. E.g.

```
@Impl(impl = classOf[TwitchChatInput], connector = classOf[chat.TwitchChatConnector])
class TwitchChatInputImpl extends Connection[chat.TwitchChatConnector] with TwitchChatInput with WithLogger {
// ...

}
```

Important: The @Impl-annotation will guide the framework to load your new connector and types.