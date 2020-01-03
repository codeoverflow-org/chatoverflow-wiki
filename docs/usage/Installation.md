This short tutorial is meant for end users of ChatOverflow and shows how to install and run the framework with all dependencies.  
If you want to set up a build environment for developing plugins or to contribute to the framework,
head over to [Build Environment](/docs/development/Setting-up-the-Build-Environment.md).

## Prerequisites

For running ChatOverflow you will need Java 8, version `1.8.0_161` or later. However we recommend that you instead use at least java 9, because it is able to re-use commonly used dependencies between plugins like the Scala Library. Java 8 re-loads these dependencies for each plugin that uses thems and keeps seperate copies of the classes in memory, thus the memory usage with Java 8 is higher.
You can download it [here](https://www.java.com/en/download/).

## Installation

1. Head over to the [releases](https://github.com/codeoverflow-org/chatoverflow/releases/latest) tab
and download the ChatOverflow `.zip` file from the assets section of the latest release.

2. Extract the zip file. (It's clever to extract it in  a folder called chatoverflow 😉)

3. If you are on Windows, execute `ChatOverflow.bat`. If you are on an UNIX operating system like MacOS or Linux execute `ChatOverflow.sh`.

4. Wait for the launcher to download all dependencies. ⏳

5. The framework will start. Have fun using it! 😃

6. To start the framework again, just re-execute the script (`ChatOverflow.bat` or `ChatOverflow.sh`, depending on your system). Don't worry, it won't download the dependencies again.
