@echo off
echo.
echo [info] running web project using vue cli command.
echo.

%~d0
cd %~dp0

cd ..
npm run dev

pause