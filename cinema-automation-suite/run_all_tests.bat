@echo off
echo 🎬 Cinema Challenge - Automation Suite
echo =====================================

echo 📋 Verificando se aplicações estão rodando...
curl -s http://localhost:5000 > nul
if errorlevel 1 (
    echo ❌ Backend não está rodando na porta 5000!
    echo Execute: start_applications.bat
    pause
    exit /b 1
)

curl -s http://localhost:3000 > nul
if errorlevel 1 (
    echo ⚠️  Frontend não está rodando na porta 3000!
    echo Alguns testes de UI podem falhar.
)

echo ✅ Aplicações verificadas!
echo.
echo Instalando dependências Python...
pip install -r requirements.txt

echo.
echo 🔥 Executando Testes de Smoke...
robot --outputdir reports/smoke --include smoke backend-tests/ frontend-tests/

echo.
echo ✅ Executando Testes Funcionais...
robot --outputdir reports/functional --include positive backend-tests/ frontend-tests/

echo.
echo 🔄 Executando Testes End-to-End...
robot --outputdir reports/e2e e2e-tests/

echo.
echo ⚡ Executando Testes de Performance...
robot --outputdir reports/performance performance-tests/

echo.
echo 📊 Gerando Relatório Consolidado...
rebot --outputdir reports/consolidated reports/*/output.xml

echo.
echo 🏁 Todos os testes executados!
echo Relatórios disponíveis em: reports/consolidated/
pause