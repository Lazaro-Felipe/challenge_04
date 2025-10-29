@echo off
echo 🎬 Iniciando Aplicações Cinema Challenge
echo ========================================

echo.
echo 📋 Verificando se as pastas existem...

if not exist "..\cinema-challenge-back" (
    echo ❌ Pasta cinema-challenge-back não encontrada!
    echo Clone o repositório: git clone https://github.com/juniorschmitz/cinema-challenge-back.git
    pause
    exit /b 1
)

if not exist "..\cinema-challenge-front" (
    echo ❌ Pasta cinema-challenge-front não encontrada!
    echo Clone o repositório: git clone https://github.com/juniorschmitz/cinema-challenge-front.git
    pause
    exit /b 1
)

echo.
echo 🚀 Iniciando Backend (porta 5000)...
start "Cinema Backend" cmd /k "cd ..\cinema-challenge-back && npm start"

echo.
echo ⏳ Aguardando backend inicializar...
timeout /t 5 /nobreak > nul

echo.
echo 🌐 Iniciando Frontend (porta 3000)...
start "Cinema Frontend" cmd /k "cd ..\cinema-challenge-front && npm start"

echo.
echo ✅ Aplicações iniciadas!
echo.
echo 📍 URLs:
echo   Backend:  http://localhost:5000
echo   Frontend: http://localhost:3000
echo.
echo 💡 Aguarde alguns segundos para as aplicações carregarem completamente
echo    antes de executar os testes.
echo.
pause