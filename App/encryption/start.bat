::@echo off
set CONFIG_ARCHIV="..\..\Data\config.7z"
set DATA_ARCHIV="ownCloudData.7z"
:: [ 0 | 1 | 3 | 5 | 7 | 9 ]
set COMPRESSION=0
set SEVENEXE="libs\7-Zip\7za.exe"
set PASSWD=%1
set RUNTIME_CONFIG_DIR=%USERPROFILE%\AppData\Local\ownCloud
set PAPPS_DOCUMENTS_DIR=%2
set RUNTIME_OWNCLOUD_DATA_DIR=%PAPPS_DOCUMENTS_DIR%ownCloud
set LOG_FILE="..\..\Data\ownCloudPortableEncryption.log"

echo This is the ownCloudPortable encryption starter script! > %LOG_FILE%
echo Configuration: >> %LOG_FILE%
echo \t CONFIG_ARCHIV = %CONFIG_ARCHIV% >> %LOG_FILE%
echo \t DATA_ARCHIV = %PAPPS_DOCUMENTS_DIR%%DATA_ARCHIV% >> %LOG_FILE%

if exist %CONFIG_ARCHIV% (
	echo Extracting portable ownCloud client config and data... >> %LOG_FILE%
	%SEVENEXE% x %CONFIG_ARCHIV% -o%RUNTIME_CONFIG_DIR% -p%PASSWD% -y >> %LOG_FILE%
	%SEVENEXE% x %PAPPS_DOCUMENTS_DIR%%DATA_ARCHIV% -o%RUNTIME_OWNCLOUD_DATA_DIR% -r -p%PASSWD% -y >> %LOG_FILE%
	del /s /f /q %PAPPS_DOCUMENTS_DIR%%DATA_ARCHIV%
)

echo Starting ownCloud client. >> %LOG_FILE%
START /WAIT ..\ownCloud\ownCloud.exe >> %LOG_FILE%

echo Encrypting ownCloud client config and data... >> %LOG_FILE%
:: Explanation:
::   -mhe to encrypt headers so nobody can browse the archive
::   -mx0 to not compress the archiv (only for performance)
%SEVENEXE% u %CONFIG_ARCHIV% %RUNTIME_CONFIG_DIR%\owncloud.cfg -mx%COMPRESSION% -mhe -p%PASSWD% -y >> %LOG_FILE%
%SEVENEXE% a %PAPPS_DOCUMENTS_DIR%%DATA_ARCHIV% %RUNTIME_OWNCLOUD_DATA_DIR%\* -mx%COMPRESSION% -mhe -p%PASSWD% -y >> %LOG_FILE%

echo Securely removing data from this computer... >> %LOG_FILE%
del /s /f /q %RUNTIME_OWNCLOUD_DATA_DIR% & rd /s /q %RUNTIME_OWNCLOUD_DATA_DIR% >> %LOG_FILE%
del /s /f /q %RUNTIME_CONFIG_DIR%\owncloud.cfg >> %LOG_FILE%

:exit
