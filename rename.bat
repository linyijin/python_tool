@echo off
echo.&echo.
title �����滻�ļ����еĲ����ַ���&color 3f
echo Note��
echo ��������������滻���ļ������ļ����µ������ļ�������ͬ�ַ�
echo.&echo.&echo.&echo.&echo.&echo.
echo.&set /p strtemp3= ������Ҫ�滻���ļ����ͣ�
echo.&set /p strtemp1= ������Ҫ�滻���ַ��������滻�ո񣩣�
echo.&set /p strtemp2= �������滻����ַ�����ɾ����ֱ�ӻس�����
setlocal enabledelayedexpansion
for /f "delims=" %%a in ('dir /a /b *.%strtemp3%') do (
set nobird=%%a
ren "%%~a" "!nobird:%strtemp1%=%strtemp2%!")
echo.&echo.&echo.&echo.&echo Done��
pause