## Run Configuration Bug 
Due to IntelliJ version differences as well as differences on platforms (e.g. Windows vs. Mac OS) the run configurations could show problems. If this error occurs, change the `classpath or module` setting under `Edit configurations...` back to the Chat Overflow root module. Now everything should be working fine again.

## Credentials value encrypted with wrong auth key
![](/img/usage/value-encrypted-wrong-key.png)  
```
ERROR configuration.CryptoUtil$  - Your environment does not work with AES256.Please update your java runtime version to at least: 1.8.0_161
```
If you see this image or error message you are probably running on an old java version that doesn't work with AES 256 bit encryption.  
To fix this error you have to update java to at least `1.8.0_161`.  
More information about this issue can be found [on stackoverflow.com](https://stackoverflow.com/questions/3862800/invalidkeyexception-illegal-key-size).
