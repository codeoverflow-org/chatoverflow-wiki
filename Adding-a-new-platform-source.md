Thank you for help for the development of *Chat Overflow*. While plugins live in their own project, source connections (e.g. to platform like Twitch or Discord) exist in the framework itself. By this, we can make sure that everyone profits from the new possibilites. This wiki entry tries to show you the different steps needed to implement a new connection.

1. Add new types to the API
2. Create a new package in the framework services package and implement the source specific connector
3. Create a impl package and implement the types you added in the API
4. Register the new type in the IO-File

## Add new types to the API

Add all needed base types and interfaces representing input / output to the correct API package. E.g. a chat input belongs to `org.codeoverflow.chatoverflow.api.io.input.chat` and should extend `ChatInput`. 

## Add a new package and connector

Create a new package inside the service package of the framework: `org.codeoverflow.chatoverflow.service`. Next, implement a connector which takes login data and creates a connection to the new platform.

With this connector, you can now implement the interfaces you just added to the API. E.g.

```
class TwitchChatInputImpl extends Connection[TwitchConnector] with TwitchChatInput {

// ...

}
```

## Register the new type

Last, register the new types in the *IO-file*. Start by adding the abstract type / interface (from the API) and the type of your implementation. E.g. `org.codeoverflow.chatoverflow.api.io.input.chat.TwitchChatInput` and `org.codeoverflow.chatoverflow.service.twitch.impl.TwitchChatInputImpl`. Next, implement two methods: 

- The first method takes a requirements container, a requirement id and a serilized value. The method is supposed to find the requirement from a plugin and set its content
- The second method is the opposite: It takes a requirement and extracts all information that should be saved

Here is a preset. You can also look a the already implemented and registered types.

```
"InterfaceType" ->
        ("ImplementedType", {
          (requirements: Requirements, id: String, serialized: String) =>
            val requirement = requirements...
            input.setSourceConnector(...)
            input.init()
            requirement.setValue(input)
            requirement
        }, {
          requirement: Requirement[_] =>
           requirement.asInstanceOf[Requirement[...]]...
        })
```



