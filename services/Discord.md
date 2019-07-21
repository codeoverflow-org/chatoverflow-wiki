<p><img align="right" width="128" height="128" src="/img/services/discord-logo.png"></p>

The discord service allows to connect to a discord text channel to get a list of recent messages,
react on new / edited / deleted messages and reactions.  

You can also send messages, files or even [fancy embeds](https://www.discord.club/static/home/img/embedg.png).  

> ### Quick note: 
> It's clever to use discord in the developer mode, so that you can easily copy the id of a server/channel/user.  
> To activate the developer mode go to `User Settings > Appearance > Advanced`
>
> ![](/img/services/discord-developer-mode.png)

## Credentials

### `authToken` _(required)_ 
The authentication token for accessing the discord api with a bot.  

First of all you need to register a new application on the [discord developer portal
](https://discordapp.com/developers/applications/).  

Then head over to the bot page and add a bot:  

![](/img/services/discord-build-a-bot.png)

Now you can retrieve the authentication token, click on copy and [add it as credentials value](/usage/Using-the-GUI.md#Set-credentials) using the GUI.

![](/img/services/discord-bot-token.png)

The only thing left to do is adding the bot to your server.  
Go to OAuth2 and create a link to login with bot scope:

![](/img/services/discord-oauth-scope.png)

If you add the following permissions the bot is allowed to do any action chatoverflow supports:

![](/img/services/discord-oauth-permissions.png)

Now you only need to copy the link, follow it, login and add the bot!


## Plugin development with Discord Chat Input
Have a look at this simple example plugin that uses an event handler to log all messages and displays the amount of messages every 5 seconds. It also logs if messages are edited, deleted and reactions are added.

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/chat/DiscordChatInput.html).
```java
import java.util.function.Consumer;
import java.util.List;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.chat.DiscordChatInput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;
import org.codeoverflow.chatoverflow.api.io.event.chat.discord.DiscordChatMessageReceiveEvent;
import org.codeoverflow.chatoverflow.api.io.event.chat.discord.DiscordChatMessageEditEvent;
import org.codeoverflow.chatoverflow.api.io.event.chat.discord.DiscordChatMessageDeleteEvent;
import org.codeoverflow.chatoverflow.api.io.event.chat.discord.DiscordReactionAddEvent;
import org.codeoverflow.chatoverflow.api.io.event.chat.discord.DiscordReaction;
import org.codeoverflow.chatoverflow.api.io.dto.chat.discord.DiscordChatMessage;

public class TestPlugin extends PluginImpl {
    //require a new discord chat input
    private Requirement<DiscordChatInput> twitchIn = 
        require.input.discordChat("discordChat", "The discord chat", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
        //Set the loop to repeat every 5 seconds (default 1 second)
        loopInterval = 5000;
    }
    
    @Override
    public void setup() {
        //set the channel for which we want to get the messages
        discordIn.get().setChannel("285809306790789120");
        log("Connected to channel with id 285809306790789120");
        
        //register the event handlers
        discordIn.get().registerChatMessageReceiveEventHandler(new MessageHandler());
        discordIn.get().registerChatMessageEditEventHandler(new MessageEditHandler());
        discordIn.get().registerChatMessageDeleteEventHandler(new MessageDeleteHandler());
        discordIn.get().registerReactionAddEventHandler(new ReactionHandler());
    }
    
    @Override
    public void loop() {
        //get the recent messages
        List<DiscordChatMessage> messages = discordIn.get().getLastMessages(getLoopInterval());
        //calculate rate of messages per second
        double rate = messages.size() / (loopInterval / 1000.0);
         log("Users are chatting at a rate of " + rate + " messages per second");
     }
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
     
     private class MessageHandler implements Consumer<DiscordChatMessageReceiveEvent> {
         
         @Override
         public void accept(DiscordChatMessageReceiveEvent event) {
             DiscordChatMessage message = event.getMessage();
             
            //log the message
            log("[Discord]" + message.toString());
         }
     }

     private class MessageEditHandler implements Consumer<DiscordChatMessageEditEvent> {
         
         @Override
         public void accept(DiscordChatMessageEditEvent event) {
             DiscordChatMessage message = event.getMessage();
             DiscordChatMessage oldMessage = event.getOldMessage();
             
            //log the old and the new message
            log("[Discord] Message '" + message.toString() + "' updated to '" + oldMessage.toString() + "'");
         }
     }

     private class MessageDeleteHandler implements Consumer<DiscordChatMessageDeleteEvent> {
         
         @Override
         public void accept(DiscordChatMessageDeleteEvent event) {
             DiscordChatMessage message = event.getMessage();
             
            //log the deleted message
            log("[Discord] Deleted message: '" + message.toString() + "'");
         }
     }

     private class ReactionHandler implements Consumer<DiscordReactionAddEvent> {
         
         @Override
         public void accept(DiscordReactionAddEvent event) {
            DiscordReaction reaction = event.getReaction();
            DiscordChatMessage message = event.getMessage();
             
            //log the reaction
            log("[Discord] Reaction " + reaction.getImageUrl() + " added to message '" + message.toString( + "'");
         }
     }
 }
```

## Plugin development with Discord Chat Output
Have a look at this simple example plugin that posts the current time to the chat every minute.

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/output/chat/DiscordChatOutput.html).

```java
import java.util.function.Consumer;
import java.util.List;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.output.chat.DiscordChatOutput;
import org.codeoverflow.chatoverflow.api.io.dto.chat.discord.DiscordEmbed;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new discord chat output
    private Requirement<DiscordChatOutput> discordOut = 
        require.output.discordChat("discordChat", "The discord chat", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
        //Set the loop to repeat every 5 minutes (default 1 second)
        loopInterval = 5 * 60 * 1000;
    }
    
    @Override
    public void setup() {
        //set the channel to which we want send the messages
        discordOut.get().setChannel("285809306790789120");
        log("Connected to channel with id 285809306790789120");

        //Send a message to the channel
        discordOut.get().sendChatMessage("Hello! 👋");
        
        //Send a file form chatoverflows data folder to the channel
        discordOut.get().sendFile("test_file.png")
    }
    
    @Override
    public void loop() {
        String timeMessage = "Es ist " 
            + LocalTime.now().format(DateTimeFormatter.ISO_LOCAL_TIME) + " Uhr!";
        log(timeMessage);

        DiscordEmbed embed = DiscordEmbed.Builder()
            .withColor("#FF7A04")
            .withTitle(timeMessage)
            .withAuthor("codeoverflow.org", "http://codeoverflow.org", "https://avatars3.githubusercontent.com/u/34384464?s=200&v=4")
            .withTimestamp(OffsetDateTime.now())
            .build();
        
        //Output the embed to the twitch chat
        discordOut.get().sendChatMessage(embed);
     }
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
}
```
