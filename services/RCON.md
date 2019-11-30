<p><img align="right" width="128" height="128" src="/img/services/rcon-material-icon.png"></p>

The RCON service can be used to execute commands on a game server using the [Source RCON Protocol](https://developer.valvesoftware.com/wiki/Source_RCON_Protocol).

Popular games that implement the RCON protocol are Minecraft, Factorio, Garrysmod and Counter-Strike: Global Offensive.  
But there are way more games that also have this functionality,  
Google will help you to find out if your game has it and how you can activate it.

## Credentials

### `address` _(required)_ 
The IPv4 address or domain of your game server.

### `password` _(required)_
The password for accessing your servers RCON socket.  
It is defined somewhere in your servers configuration (different for each game, google will help you).

### `port` _(optional)_
The port on which the RCON socket runs.  
It is defined somewhere in your servers configuration (different for each game, google will help you).

## Plugin development with RCON Output
Have a look at this simple plugin that says hello to all players on a minecraft server using rcon:

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/RconOutput.html).
```java

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.RconOutput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new rcon output
    private Requirement<RconOutput> rcon = 
        require.output.rcon("rcon", "Connect to a minecraft server using RCON", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
    }
    
    @Override
    public void setup() {
        //execute a command
        rcon.get().sendCommand("say Hello World!");

    }
    
    @Override
    public void loop() {}
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
 }
```

## Plugin development with RCON Input
If you want to also get the response of a command have a look at this simple plugin:

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/RconInput.html).
```java

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.RconInput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new rcon input
    private Requirement<RconInput> rcon = 
        require.input.rcon("rcon", "Connect to a minecraft server using RCON", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
    }
    
    @Override
    public void setup() {
        //execute a command and log the response
        String response = rcon.get().getCommandOutput("list");
        log(response);

    }
    
    @Override
    public void loop() {}
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
 }
```
