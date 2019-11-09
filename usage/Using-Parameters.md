Plugin Developers can request custom input from a user using `Parameters`. There are currently 8 types of parameters.
## String parameter
The string parameter requires you to enter a string. 

Example: `The snow is snowier than before`

Example for developers (Java): 
```java
private Requirement<StringParameter> motd = require.parameter.stringParameter("motd");
    
@Override
public void setup() {
  log("Message of the day: " + motd.get().get());
}
```
## Integer parameter
The integer parameter requires you to enter an integer number.

Example: `5`, `7`, `-10`

Example for developers (Java): 
```java
private Requirement<IntegerParameter> age = require.parameter.integerParameter("age");
@Override
public void setup() {
  log("You are " + age.get().get() + " years old.");
}
```
## Double parameter
The double parameter requires you to enter a floating point number.

Example: `3.14159265359`, `5`, `-10.5`

Example for developers (Java): 
```java
private Requirement<DoubleParameter> size = require.parameter.doubleParameter("size");
@Override
public void setup() {
  log("You are " + size.get().get() + " meters tall.");
}
```
## Boolean parameter
The boolean parameter requires you to enter a boolean. Note that any input that isn't `true` will default to false.

Example: `true`, `false`

Example for developers (Java):
```java
private Requirement<BooleanParameter> debug = require.parameter.booleanParameter("debug");
@Override
public void setup() {
  if(debug.get().get()) {
    log("Debug mode has been activated.");
  }
}
```
## URI parameter
The URI parameter reqires you to enter an [Uniform Resource Identifier](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier), most comonly a link to a website.

Example: `donate/to/team.txt`, `trees.html`, `org.jpg`, `http://www.codeoverflow.org/`

Example for developers (java): 
```java
private Requirement<UriParameter> twitchURL = require.parameter.uriParameter("twitchURL");
@Override
public void setup() {
  log("Your twitch URL is: " + twitchURL.get().get().toString());
}
```
## Color parameter
The color parameter requires you to enter a Color. The color has to be in one of the following formats:

(R = Red, G = Green, B = Blue, A = Alpha)

`#RRGGBB` or `#RRGGBBAA`: The color in hexadecimal (0-9, A-F).

`R,G,B` or `R,G,B,A`: The color in integer numbers (0-255) or floting point numbers (0.0-1.0)

Example: `#FFFFFF`, `251,121,1`, `#FFFF00BB`, `255,255,255,10`, `1.0,1.0,0.5,1.0`, `1.0,0.7,0.3`

Example for developers:
```java
private Requirement<ColorParameter> favColor = require.parameter.colorParameter("favColor");
@Override
public void setup() {
  log("Your favorite Color is: " + favColor.get().get().getRed() + " " + favColor.get().get().getGreen() + " " + favColor.get().get().getGreen());
}
```
## List parameter
The list parameter requires you to enter a list. You have to seperate entries by using a comma.

Example: `i,like,trees`, `message`, `do you like,this wiki entry?`

Example for developers (Java):
```java
private Requirement<ListParameter> messages = require.parameter.listParameter("messages");
@Override
public void setup() {
  log("You entered the following messages:");
  for (String string : messages.get().get()) {
    log(string);
  }
}
```
## Map parameter
The map parameter requires you to enter a map. A map uses the following format: `key;value` or `(key;value)`. You have to seperate entries by using a comma.

Example: `(website;https://github.com/codeoverflow-org/chatoverflow)`, `twitch;prime`, `(key1:value1),(key2;value2)`, `key1:value1,key2;value2`

Example for developers (Java):
```java
private Requirement<MapParameter> commands = require.parameter.mapParameter("commands");
@Override
public void setup() {
  log("You're using the following commands:");
  for (String key : commands.get().get().keySet()) {
    log(key + ": " + commands.get().get().get(key));
  }
}
```
## Date parameter
The date parameter requires you to enter a valid date following the [ISO-8601 standard](https://en.wikipedia.org/wiki/ISO_8601). It is defined as:

`YYYY-MM-DD` (`Y` = year, `M` = month, `D` = day)

Example: `2011-12-30`, `2019-11-09`

Example for developers (Java):
```java
private Requirement<DateParameter> exam = require.parameter.dateParameter("exam");
@Override
public void setup() {
  log("Your exam is at " + exam.get().get().toString());
}
```
## Time parameter
The time parameter requires you to enter a valid time following the [ISO-8601 standard](https://en.wikipedia.org/wiki/ISO_8601). It is defined as:

`HH:MM:SS` (`H` = hour, `M` = minute, `S` = second)  
or  
`HH:MM`


Example: `10:15`, `18:36:10`

Example for developers (Java):
```java
private Requirement<TimeParameter> alarm = require.parameter.timeParameter("alarm");
@Override
public void setup() {
  log("The alarm is set to " + alarm.get().get().toString());
}
```
## Date Time parameter
The date time parameter requires you to enter a valid time at a specific date following the [ISO-8601 standard](https://en.wikipedia.org/wiki/ISO_8601). It is defined as:

`YYYY-MM-DDThh:mm:ss` (`Y` = year, `M` = month, `D` = day, `h` = hour, `m` = minute, `s` = second)  
or  
`YYYY-MM-DDThh:mm`


Example: `2011-12-30T10:15:30`, `2019-11-09T18:40`

Example for developers (Java):
```java
private Requirement<TimeParameter> appointment = 
                                    require.parameter.timeParameter("appointment");
@Override
public void setup() {
  log("Yo have an appointment on " + appointment.get().get().toLocalDate().toString() 
    + " at " + appointment.get().get().toLocalTime().toString());
}
```