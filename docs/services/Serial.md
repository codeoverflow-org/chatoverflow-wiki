<p><img align="right" width="128" height="54" src="/img/services/serial-arduino-logo.png"></p>

The Serial service allows you to communicate with a device that is connected to your PC over a serial port.  

The most common example is exchanging data with an [arduino](https://www.arduino.cc/) over USB.

## Credentials

### `port` _(required)_ 

The serial port you want to communicate with. Finding the right port is different on every operating system:  

**Windows:**
1. Open Device Manager, and expand the Ports (COM & LPT) list  
2. Note the port name between the braces (e.g. `COM3`)  
  ![](/img/services/serial-ports.png/)

**Mac:**  
1. Open terminal and type: 
   ```shell
   ls /dev/*
   ```  
2. Note the port number listed for `/dev/tty.usbmodem*` or `/dev/tty.usbserial*.`  
   The port number is represented with `*` here.  

**Linux:**  
1. Open terminal and type: 
   ```shell
   ls /dev/tty*
   ``` 
2. Note the port number listed for `/dev/ttyUSB*` or `/dev/ttyACM*`  
   The port number is represented with `*` here

### `baudRate` _(optional)_

If you want to use a custom baud rate to communicate with the device you can set it here.  
Default value is `9600`.


## Plugin development with Serial Input
Have a look at this simple example plugin that prints incoming data to log:

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/SerialInput.html).
```java
import java.util.function.Consumer;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.SerialInput;
import org.codeoverflow.chatoverflow.api.io.event.serial.SerialDataAvailableEvent;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new serial input
    private Requirement<SerialInput> serialIn = 
        require.input.serial("serialIn", "An arduino connected to the serial port", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
    }
    
    @Override
    public void setup() {
        //register the message handler that reacts on incoming messages
        serialIn.get().registerDataAvailableEventHandler(new DataHandler());
    }
    
    @Override
    public void loop() {}
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
     
     private class DataHandler implements Consumer<SerialDataAvailableEvent> {
         
         @Override
         public void accept(SerialDataAvailableEvent event) {
            //print the incoming string to the log
            log("[Serial]" + event.getAsString());
         }
     }
 }
```

## Plugin development with Serial Output
Have a look at this simple example plugin that sends `ping` to the connected device

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/output/SerialOutput.html).

```java
import java.util.function.Consumer;
import java.util.List;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.output.SerialOutput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new serial output
    private Requirement<SerialOutput> serialOut = 
        require.output.serial("serialOut", "An arduino connected to the serial port", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
        //Set the loop to repeat every 30 seconds (default 1 second)
        loopInterval = 30 * 1000;
    }
    
    @Override
    public void setup() {}
    
    @Override
    public void loop() {
        //Send ping to serial port
        serialOut.getPrintStream().println("ping");
     }
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
}
```

### Example arduino script

A simple ping-pong example script for your arduino.
```cpp
String inputString = "";     
boolean stringComplete = false; 

void setup() {
    Serial.begin(9600);
}

// the loop routine runs over and over again forever
void loop() {
    while (Serial.available()) {
        char inChar = (char)Serial.read();
            inputString += inChar;
            if (inChar == '\n') {
            stringComplete = true;
        }
    }
    if (stringComplete) {
        Serial.println("pong");
        stringComplete = false;
    }
  delay(1);        // delay in between reads for stability
}
```
