# Encrypted ownCloud Portable Client

This is a portable ownCloud Client that runs on Windows.
At first run it will setup a portable ownCloud Client and starts it.
When you close the client by right-clicking the tray icon and selecting exit it
will put your documents and the client with all config into an encrypted archiv
using 7-Zip.

## Used software

### PortableApps ownCloud package
I used the PortableApps Stub from http://portableapps.com/node/37132. Thanks to the author.

### ownCloud
Currently packaged is the ownCloud client version 1.8.0 (build 4893) from https://owncloud.org/install/#install-clients.

### 7-Zip
For encrypted packaging a 7za.exe is included. This is the official portable one in version 9.38 beta from http://www.7-zip.org/download.html.

If you ask yourself if 7-Zip is secure enough, please reefer to http://security.stackexchange.com/questions/29375/is-7-zips-aes-encryption-just-as-secure-as-truecrypts-version.
