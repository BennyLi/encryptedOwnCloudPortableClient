@echo off
set ARCHIV="documents-sync.7z"
:: [ 0 | 1 | 3 | 5 | 7 | 9 ]
set COMPRESSION=0
set SEVENEXE="libs\7-Zip\7za.exe"
set PASSWD=%1
set LOG_FILE="ownCloudPortable.log"

echo This is the ownCloudPortable starter script! > %LOG_FILE%

if exist %ARCHIV% (
	echo Extracting portable ownCloud client and data... >> %LOG_FILE%

	%SEVENEXE% x %ARCHIV% -p%PASSWD% -y >> %LOG_FILE%

) else (
	echo Creating directory structure and downloading client... >> %LOG_FILE%

	mkdir Documents >> %LOG_FILE%
	::xcopy libs\ownCloudPortable ownCloudPortable\ /E >> %LOG_FILE%
	%SEVENEXE% x libs\ownCloudPortable.7z -y >> %LOG_FILE%
)

:: Check if the extraction worked (password verification)
if not exist ownCloudPortable (
  echo Something went wrong! >> %LOG_FILE%
	goto exit
)

echo Starting ownCloud client. >> %LOG_FILE%
START /WAIT ownCloudPortable\ownCloudPortable.exe >> %LOG_FILE%

echo Encrypting ownCloud client and data... >> %LOG_FILE%
:: First we need to remove the old mutable data to guarantee deletion of files.
%SEVENEXE% d documents-sync.7z ownCloudPortable/Data/* -r -p%PASSWD% -y >> %LOG_FILE%
%SEVENEXE% d documents-sync.7z Documents/* -r -p%PASSWD% -y >> %LOG_FILE%
:: Explanation:
::   -mhe to encrypt headers so nobody can browse the archive
::   -mx0 to not compress the archiv (only for performance)
%SEVENEXE% u documents-sync.7z Documents -mx%COMPRESSION% -mhe -p%PASSWD% -y >> %LOG_FILE%
%SEVENEXE% u documents-sync.7z ownCloudPortable -mx%COMPRESSION% -mhe -p%PASSWD% -y >> %LOG_FILE%

echo Securely removing data from this computer... >> %LOG_FILE%
del /s /f /q ownCloudPortable & rd /s /q ownCloudPortable >> %LOG_FILE%
del /s /f /q Documents & rd /s /q Documents >> %LOG_FILE%

:exit
