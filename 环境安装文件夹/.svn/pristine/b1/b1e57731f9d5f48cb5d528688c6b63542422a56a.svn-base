::`wmic datafile where name="C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" get Version `
::FOR /F "eol=; tokens=2,3* delims=, " %i in (myfile.txt) do @echo %i %j %k
::FOR /F "usebackq eol=; tokens=2,3* delims=, " %i in (
::`C:\Windows\System32\wbem\WMIC.exe datafile where name='C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" get Version `) do @echo %i %j %k
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set "reg=HKEY_CURRENT_USER\SOFTWARE\Google\Chrome\BLBeacon"
:: 搜索的注册表 的 路径
set "search=version"
:: 搜索键值的的数据
set value=0
for /f "tokens=*" %%i in ('reg query %reg% /s') do (
set str=%%i
set str=!str:^<=!
set str=!str:^>=!
echo !str!|find "%reg%" >nul && set sig=!str! || (
echo !str!|find "%search%" >nul && (echo !sig! & echo %%i)
)
) 2>nul
pause

