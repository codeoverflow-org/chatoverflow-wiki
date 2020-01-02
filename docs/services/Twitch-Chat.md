<p><img align="right" width="128" height="128" src="/docs/img/services/twitch-glitch.png"></p>  

The Twitch chat service allows plugins to connect to a channels chat by using IRC.  

They can get a List of recent messages, listen for new messages or send messages to the chat.

## Credentials

### `oauth` _(required)_ 
The authentication token for accessing the Twitch IRC chat with your account.  

If you don't have such a token yet you can generate it on  https://twitchapps.com/tmi/.

Just log into your Twitch account and copy the token.  
Then add it as a credentials value with the key `oauth` as described [here](/docs/usage/Using-the-GUI.md#set-credentials).

_Note: Copy the entire key **including** the `oauth:` at the beginning._

## Plugin development with Twitch Chat Input
Have a look at this simple example plugin that uses an event handler to log all messages and displays the amount of messages every 5 seconds:

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/chat/TwitchChatInput.html).

```java tab=
import java.util.function.Consumer;
import java.util.List;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.chat.TwitchChatInput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;
import org.codeoverflow.chatoverflow.api.io.event.chat.twitch.TwitchChatMessageReceiveEvent;
import org.codeoverflow.chatoverflow.api.io.dto.chat.twitch.TwitchChatMessage;

public class TestPlugin extends PluginImpl {
    //require a new Twitch chat input
    private Requirement<TwitchChatInput> twitchIn = 
        require.input.twitchChat("twitchChat", "The Twitch chat", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
        //Set the loop to repeat every 5 seconds (default 1 second)
        loopInterval = 5000;
    }
    
    @Override
    public void setup() {
        //set the channel for which we want to get the messages
        twitchIn.get().setChannel("#skate702");
        log("Connected to skate702s Twitch chat!");
        
        //register the message handler that reacts on incoming messages
        twitchIn.get().registerChatMessageReceiveEventHandler(new MessageHandler());
    }
    
    @Override
    public void loop() {
        //get the recent messages
        List<TwitchChatMessage> messages = twitchIn.get().getLastMessages(getLoopInterval());
        //calculate rate of messages per second
        double rate = messages.size() / (loopInterval / 1000.0);
         log("Users are chatting at a rate of " + rate + " messages per second");
     }
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
     
     private class MessageHandler implements Consumer<TwitchChatMessageReceiveEvent> {
         
         @Override
         public void accept(TwitchChatMessageReceiveEvent event) {
             TwitchChatMessage message = event.getMessage();
             
            //print the incoming message to the log (including the author)
            log("[Twitch Chat]" + message.toString());
         }
     }
 }
```

## Plugin development with Twitch Chat Output
Have a look at this simple example plugin that posts the current time to the chat every minute.

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/output/chat/TwitchChatOutput.html).

```java tab=
import java.util.function.Consumer;
import java.util.List;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.output.chat.TwitchChatOutput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new Twitch chat output
    private Requirement<TwitchChatOutput> twitchOut = 
        require.output.twitchChat("twitchChat", "The Twitch chat", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
        //Set the loop to repeat every 5 minutes (default 1 second)
        loopInterval = 5 * 60 * 1000;
    }
    
    @Override
    public void setup() {
        //set the channel to which we want send the messages
        twitchOut.get().setChannel("#skate702");
        log("Connected to skate702s Twitch chat!");
    }
    
    @Override
    public void loop() {
        String timeMessage = "Es ist " 
            + LocalTime.now().format(DateTimeFormatter.ISO_LOCAL_TIME) + " Uhr!";
        log(timeMessage);
        
        //Output the message to the Twitch chat
        twitchOut.get().sendChatMessage(timeMessage);
     }
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
}
```
