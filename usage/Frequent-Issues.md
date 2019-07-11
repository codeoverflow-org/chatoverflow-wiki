## Run Configuration Bug 
Due to IntelliJ version differences and usage on Windows vs. Mac OS, the run configurations show problems, sometimes. Change the *classpath or module* under `Edit configurations...` back to the Chat Overflow root module, and everything should be fine.

## Credentials value encrypted with wrong auth key
![](/img/value-encrypted-wrong-key.png)  
```
ERROR configuration.CryptoUtil$  - Your environment does not work with AES256.Please update your java runtime version to at least: 1.8.0_161
```
If you see this image or error message you are probably running on an old java version that doesn't work with AES 256 bit encryption.  
Please follow the instructions from the error message and update java to at least `1.8.0_161`.  
More information about the issue can be found [on stackoverflow.com](https://stackoverflow.com/questions/3862800/invalidkeyexception-illegal-key-size).
