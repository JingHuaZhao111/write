@echo off
rem create by NettQun

rem 这里写仓库路径
set REPOSITORY_PATH=D:\soft\apache-maven-3.6.1-bin\apache-maven-3.6.1\mvn_resp
rem 正在搜索...
for /f "delims=" %%i in ('dir /b /s "%REPOSITORY_PATH%\*lastUpdated*"') do (
	echo %%i
	del /s /q "%%i"
)
rem 搜索完毕
pause