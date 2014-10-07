@echo off
set _=%CD%\benchmark-logger.py
echo %_% %1
monkeyrunner %_% %1
pause
