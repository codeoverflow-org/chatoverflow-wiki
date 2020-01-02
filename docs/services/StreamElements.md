<p><img align="right" width="200" height="51" src="/docs/img/services/streamelements-logo.png"></p>

By using the StreamElements service you can react on donations, subscriptions and follows in your stream. 

## Credentials

### `jwt-token` _(required)_ 
The key used for authentication with the StreamElements api. 

You find your JWT at https://streamelements.com/dashboard/account/channels.

Click on `Show Secrets`, copy the entire key labeled `JWT Token`, add it as a credentials value with the key `jwt-token` and you're done!

![](/docs/img/services/streamelements-token.png)

## Plugin development with the StreamElements Event Input
This simple example plugin logs all Subscriptions:

For other event types just use the appropriate register method of the input. The StreamElements event input is capable of all the following events:

- Follows
- Subscriptions
- Donations
- Cheers
- Raids
- Hosts

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/event/StreamElementsEventInput.html).

```java
import java.util.function.Consumer;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.event.StreamElementsEventInput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;
import org.codeoverflow.chatoverflow.api.io.event.stream.streamelements.StreamElementsSubscriptionEvent;
import org.codeoverflow.chatoverflow.api.io.dto.stat.stream.streamelements.StreamElementsSubscription;

public class TestPlugin extends PluginImpl {
    // require a StreamElements event input
    private Requirement<StreamElementsEventInput> streamElementsIn = 
        require.input.streamElements("streamElements", "Access to the StreamElements API", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
    }
    
    @Override
    public void setup() {
        // register the subscription event handler that triggers if someone subscribes
        streamElementsIn.get().registerSubscriptionEventHandler(new SubHandler());
    }
    
    @Override
    public void loop() {
    }
     
    @Override 
    public void shutdown() {
        log("Shutdown!");
    }
     
    private class SubHandler implements Consumer<StreamElementsSubscriptionEvent> { 
        @Override
        public void accept(StreamElementsSubscriptionEvent event) {
            StreamElementsSubscriptionEvent sub = event.getInfo();
             
            // Print information about the event to the log
            log(sub.getSubscriber().getDisplayName() + " subscribed. Resub streak: " 
                + sub.getResub());
        }
     }
 }
```