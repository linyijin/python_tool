@echo off
echo.&echo.
title 批量替换文件名中的部分字符串&color 3f
echo Note：
echo 本批处理可批量替换本文件所在文件夹下的所有文件名的相同字符
echo.&echo.&echo.&echo.&echo.&echo.
echo.&set /p strtemp3= 请输入要替换的文件类型：
echo.&set /p strtemp1= 请输入要替换的字符串（可替换空格）：
echo.&set /p strtemp2= 请输入替换后的字符串（删除则直接回车）：
setlocal enabledelayedexpansion
for /f "delims=" %%a in ('dir /a /b *.%strtemp3%') do (
set nobird=%%a
ren "%%~a" "!nobird:%strtemp1%=%strtemp2%!")
echo.&echo.&echo.&echo.&echo Done！
pause