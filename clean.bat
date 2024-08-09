@echo off
setlocal

where python >nul 2>&1
if %errorlevel%==0 (
    echo Python está instalado.
) else (
    echo Python não está instalado. Instalando Python...

    set "PYTHON_VERSION=3.11.4"
    set "PYTHON_INSTALLER=python-%PYTHON_VERSION%-amd64.exe"
    set "PYTHON_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/%PYTHON_INSTALLER%"

    
    echo Downloading Python %PYTHON_VERSION%...
    powershell -Command "Invoke-WebRequest -Uri '%PYTHON_URL%' -OutFile '%PYTHON_INSTALLER%'"

    
    echo Instalando Python...
    start /wait %PYTHON_INSTALLER% /quiet InstallAllUsers=1 PrependPath=1

    
    del %PYTHON_INSTALLER%

    
    where python >nul 2>&1
    if %errorlevel%==0 (
        echo Python instalado com sucesso.
    ) else (
        echo Instalação do python falhou.
        exit /b 1
    )
)
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c cd /d %~dp0 && %~fnx0' -Verb runAs"
    exit /b
)
cd /d "%~dp0"
chcp 65001 >nul
color 04

cls


:menu
cls
echo      ▄▄▄       ███▄    █  ▄████▄   ██▓    ▄▄▄      ▓█████▄ 
echo     ▒████▄     ██ ▀█   █ ▒██▀ ▀█  ▓██▒   ▒████▄    ▒██▀ ██▌
echo     ▒██  ▀█▄  ▓██  ▀█ ██▒▒▓█    ▄ ▒██░   ▒██  ▀█▄  ░██   █▌
echo     ░██▄▄▄▄██ ▓██▒  ▐▌██▒▒▓▓▄ ▄██▒▒██░   ░██▄▄▄▄██ ░▓█▄   ▌
echo     ▓█   ▓██▒▒██░   ▓██░▒ ▓███▀ ░░██████▒▓█   ▓██▒░▒████▓ 
echo     ▒▒   ▓▒█░░ ▒░   ▒ ▒ ░ ░▒ ▒  ░░ ▒░▓  ░▒▒   ▓▒█░ ▒▒▓  ▒ 
echo      ▒   ▒▒ ░░ ░░   ░ ▒░  ░  ▒   ░ ░ ▒  ░ ▒   ▒▒ ░ ░ ▒  ▒ 
echo      ░   ▒      ░   ░ ░ ░          ░ ░    ░   ▒    ░ ░  ░ 
echo          ░  ░         ░ ░ ░          ░  ░     ░  ░   ░    
echo                         ░                          ░      
echo 1. Limpar arquivos temporários e limpeza de disco
echo 2. Limpar network
echo 3. Resetar google chrome
echo 4. Sair
echo ===========================
set /p choice=Digite sua opção (1-4):

if %choice%==1 goto clean
if %choice%==2 goto clean_network
if %choice%==3 goto clean_browser
if %choice%==4 goto exit
goto menu


:clean
cls
echo Limpando ...
python clean.py
pause
goto menu

:clean_network
cls
echo Limpando rede ...
python clean_network.py
pause
goto menu

:clean_browser
cls
echo Resetando google chrome ...
python clean_browser.py
pause
goto menu


:exit
exit