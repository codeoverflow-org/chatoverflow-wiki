## Run Configuration Bug 
Because of the differences in IntelliJ versions the run configurations could be broken. If they are broken, change the `classpath or module` setting in `Edit configurations...` to ChatOverflow root module (`chatoverflow`). Now everything should be working fine again.

## Credentials value encrypted with wrong auth key
![](/img/usage/value-encrypted-wrong-key.png)  
```
ERROR configuration.CryptoUtil$  - Your environment does not work with AES256.Please update your Java runtime version to at least: 1.8.0_161
```
If you see this image or error message you are probably running on an old Java version that doesn't work with AES 256 bit encryption.  
To fix this error you have to update Java to version `1.8.0_161` or later.  
More information about this issue can be found [on stackoverflow.com](https://stackoverflow.com/questions/3862800/invalidkeyexception-illegal-key-size).

## "GUI not found" error message

A common problem is the message "GUI couldn't be found on the classpath! Has the GUI been built?" when building the gui or everything freshly, using the `[Advanced]`-configuration. This is due to a IntelliJ bug / problem.

Solution: Use the *Refresh sbt project* button, inside IntelliJ. This should make IntelliJ find, load and start the GUI component. It can be found inside the sbt overlay window:

![](/img/usage/refresh-sbt.png)  

