<p><img align="right" width="128" height="128" src="/img/services/file-material-icon.png"></p>

The file service allows you to perform file operations that would otherwise be prohibited by the sandbox security manager.  
It features easy ways to read, write or delete files and for managing subdirectories.  
To keep you safe from malicious plugins all file operations are restricted to the data folder.

## Credentials

The file service doesn't require any credentials.

## Plugin development with File Input
Have a look at this simple example plugin that loads files from the data folder:

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/FileInput.html).
```java
import java.util.Optional;
import java.awt.image.BufferedImage;

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.FileInput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new file input
    private Requirement<FileInput> fsi = 
        require.input.file("fileInput", "Read data from the file system", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
    }
    
    @Override
    public void setup() {
        //read text from the test.txt file in the data folder to a string:
        Optional<String> text = fsi.get().getFile("test.txt");
        if (text.isPresent()) {
            log(text.get());
        } else {
            log("Couldn't read test.txt");
        }

        //read the content of a file into a byte array
        Optional<byte[]> raw = fsi.get().getBinaryFile("test.bin");
        if (raw.isPresent()) {
            byte[] array = raw.get();
            //...

        } else {
            log("Couldn't read test.bin");
        }

        //load an image
        Optional<BufferedImage> img = fsi.get().getImage("test.png");
        if (img.isPresent()) {
            BufferedImage image = img.get();
            //...

        } else {
            log("Couldn't load test.png");
        }
    }
    
    @Override
    public void loop() {}
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
 }
```

## Plugin development with File Output
Have a look at this simple example plugin that saves files and creates or deletes directories in the data folder.

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/output/FileOutput.html).

***TODO: Example for file output***
<!--
```java
import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.output.FileOutput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new file output
    private Requirement<FileOutput> fso = 
        require.output.serial("fileOutput", "Interact with the file system", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
    }
    
    @Override
    public void setup() {
        //TODO
    }
    
    @Override
    public void loop() {}
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
}
```
-->