<p><img align="right" src="/img/services/tipeeestream-logo.png"></p>

By using the TipeeeStream service you can react on donations, subscriptions and follows in your stream.  
Just listen to the events provided by the TipeeeStream event input.

## Credentials

### `username` _(required)_
Guess what: Your TipeeeStream username 😉.

Just add a new credentials value with `username` as key and your username as value.  
A guide can be found [here](/usage/Using-the-GUI.md#Set-credentials).

### `apiKey` _(required)_ 
The key used for authentication to the TipeeeStream api. 

You find your key on https://www.tipeeestream.com/dashboard/api-key.

Click on `Show`, copy the entire key, add it as a credentials value with the key `apikey` and you're done!

![](/img/services/tipeeestream-apikey.png)

## Plugin development with TipeeeStream Event Input
This simple example plugin logs all Subscriptions:

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/event/TipeeestreamEventInput.html).
```java
import java.util.function.Consumer;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.event.TipeeestreamEventInput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;
import org.codeoverflow.chatoverflow.api.io.event.stream.tipeeestream.TipeeestreamSubscriptionEvent;
import org.codeoverflow.chatoverflow.api.io.dto.stat.stream.tipeeestream.TipeeestreamSubscription;

public class TestPlugin extends PluginImpl {
    // require a new TipeeeStream event input
    private Requirement<TipeeestreamEventInput> tipeeeIn = 
        require.input.tipeeeStream("tipeeestream", "Connection to the TipeeeStream api", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
    }
    
    @Override
    public void setup() {
        //register the subscription event handler that reacts on subscriptions 
        twitchIn.get().registerChatMessageReceiveEventHandler(new SubHandler());
    }
    
    @Override
    public void loop() {
    }
     
    @Override 
    public void shutdown() {
        log("Shutdown!");
    }
      
    private class SubHandler implements Consumer<TipeeestreamSubscriptionEvent> {
        @Override
        public void accept(TipeeestreamSubscriptionEvent event) {
            TipeeestreamSubscription sub = event.getInfo();
            
            // print information about the event to the log
            log(sub.getSubscriber().getDisplayName() + " subscribed. Resub streak: " 
                + sub.getResub());
        }
    }
}
```