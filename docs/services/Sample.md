<p><img align="right" width="128" height="128" src="/docs/img/services/sample-material-icon.png"></p>

The Sample service is just an example on how a connector should look like.
And this wiki page is just an example how a wiki page for a connector should look like.

First you have a short description.

The image in the upper right corner can be done with the following html in the first line of the page:
```html
<p><img align="right" width="128" height="128" src="/docs/img/services/sample-material-icon.png"></p>
```
The image should be uploaded to [img/services](https://github.com/codeoverflow-org/chatoverflow-wiki/tree/master/img/services).

## Credentials

The sample service doesn't require any credentials.
Otherwise this section should list all required credentials and show how to obtain them, see [discord service](/docs/services/Discord.md).

## Plugin development with Sample Input
Have a look at this simple sample plugin:

For more information have a look at the [javadoc](http://docs.codeoverflow.org/chatoverflow-api/org/codeoverflow/chatoverflow/api/io/input/SampleInput.html).

```java linenums="1" tab=

import org.codeoverflow.chatoverflow.api.plugin.configuration.Requirement;
import org.codeoverflow.chatoverflow.api.io.input.SampleInput;
import org.codeoverflow.chatoverflow.api.plugin.PluginImpl;
import org.codeoverflow.chatoverflow.api.plugin.PluginManager;

public class TestPlugin extends PluginImpl {
    //require a new sample input
    private Requirement<SampleInput> sample = 
        require.input.sample("sample", "Some description", false);
    
    public TestPlugin(PluginManager pluginManager) {
        super(pluginManager);
    }
    
    @Override
    public void setup() {
        //some code that shows of the general usage of the service here
        //...

    }
    
    @Override
    public void loop() {}
     
     @Override 
     public void shutdown() {
         log("Shutdown!");
     }
 }
```