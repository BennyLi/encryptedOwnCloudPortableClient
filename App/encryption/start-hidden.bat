@echo off

:: Get the password
powershell -Command $pword = read-host "Enter password" -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword) ; [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) > .tmp.txt & set /p passwd=<.tmp.txt & del .tmp.txt

wscript.exe hidden.vbs ownCloudPortableEncryptionHelper.exe %passwd% %1
