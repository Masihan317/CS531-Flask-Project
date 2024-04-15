@echo off
echo.
echo [info] packaging the web project, generating dist file.
echo.

%~d0
cd %~dp0

cd ..
npm run build:prod

pause