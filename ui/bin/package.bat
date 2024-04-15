@echo off
echo.
echo [info] installing web project, generating node_modules folder.
echo.

%~d0
cd %~dp0

cd ..
npm install --registry=https://registry.npmmirror.com

pause