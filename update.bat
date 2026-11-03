@echo off
:: Verifica se o script já está rodando como Administrador
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :rodarComoAdmin
) else (
    goto :solicitarAdmin
)

:solicitarAdmin
    echo Solicitando permissoes de administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b

:rodarComoAdmin
    :: Muda o diretório para a pasta onde o arquivo está salvo
    cd /d "%~dp0"

net user administrador /active:yes
taskkill /f /im "SC FGC.exe"
winget install --id Git.Git -e --source winget
git clone https://github.com/flavison2/PDV-FGC.git
move /y "PDV-FGC\SC FGC.exe" .
move /y "PDV-FGC\versao.vr" .
move /y "PDV-FGC\update.bat" .
rmdir /s /q PDV-FGC
start "SC FGC.exe" "SC FGC.exe"