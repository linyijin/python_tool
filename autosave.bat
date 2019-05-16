@echo off
echo %cd%
set AFolder=img
set BFolder=json
md %AFolder%
md %BFolder%
for /f "delims=" %%a in ('dir /b /s *.json') do move "%%a" C:\Users\lion\Desktop\img\json
for /f "delims=" %%a in ('dir /b /s *.png') do move "%%a" C:\Users\lion\Desktop\img\img
pause