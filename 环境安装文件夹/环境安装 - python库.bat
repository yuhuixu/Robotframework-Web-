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
::For /f "tokens=*" %%i in (a.txt) do (Set n=%%i&Set m=!n!!n!&Echo !n! !m!)

::添加环境变量Python pip
@echo off
echo 添加python环境变量
::需要增加判断，是否存在环境变量，有则不替换，没有则替换
C:\Windows\System32\wbem\WMIC.exe ENVIRONMENT where "name='path' and username='<system>'" set VariableValue="%path%;C:\Python27;c:\Python27\scripts;C:\Windows\System32\wbem;C:\Windows\System32"

cd appdirs-1.4.0
python setup.py install 
cd setuptools-34.2.0
python setup.py install   
cd ../pip-9.0.1
python setup.py install
cd ../AutoItLibrary-1.1
python setup.py install
cd ..

pip.exe install robotframework  
pip.exe install robotframework-ride
pip.exe install selenium2lib_myself.zip
::pip.exe install  robotframework-selenium2library
pip.exe install robotframework-excellibrary
pip.exe install PyMySQL
pip.exe install robotframework-databaselibrary
::需要添加operatesystem的安装
::需要添加autoitlibrary的安装
pause





