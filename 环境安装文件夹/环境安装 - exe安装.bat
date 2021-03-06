@echo off
title Auto Install
::color 1F
::author-徐育辉
::time-2017年2月24日
@echo off
CLS
ECHO.
ECHO ================================
ECHO 获取批处理文件管理员权限
ECHO ================================
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO ********************************
ECHO 请求 UAC 权限批准……
ECHO ********************************
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " " >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B
:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul & shift /1)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 以下为需要运行的批处理文件代码 ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem 本行以下可修改为你需要的bat命令(从上面三行冒号开始到下面都可删改)
ECHO 开始安装
ECHO.
::增加需求，判断是否有软件，版本是否正确，正确则不安装，错误或者没有则安装软件
::缺少chromedriver.exe的安装和配置
::C:\Windows\System32\wbem\WMIC.exe ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%path%;C:\Python27;c:\Python27\scripts;C:\Windows\System32\wbem;C:\Windows\System32"
call:installEXE python-2.7.13.amd64.msi
call:installEXE pycrypto-2.6.win-amd64-py2.7.exe
call:installEXE VCForPython27.msi
call:installEXE wxPython2.8-win64-unicode-2.8.12.1-py27.exe
call:installEXE pywin32-220.win-amd64-py2.7.exe
call:installEXE autoit-v3-setup.exe

:installEXE
echo.
start /WAIT %~1 /QB REBOOT=Suppress  
if %errorlevel%==0 (echo  %~1 -- OK) else (echo  %~1 -- error)
GOTO:EOF