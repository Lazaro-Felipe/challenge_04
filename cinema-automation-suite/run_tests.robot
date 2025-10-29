*** Settings ***
Documentation    Suite principal de testes do Cinema Challenge
Resource    config/global_config.robot

*** Test Cases ***
Executar Suite Completa
    [Documentation]    Executa todos os testes em ordem de prioridade
    [Tags]    suite_master
    
    Log To Console    🎬 Iniciando Cinema Test Suite
    Log To Console    ================================
    
    # 1. Testes de Smoke (críticos)
    Run Keyword And Continue On Failure    Run Tests    backend-tests/auth_advanced.robot --include smoke
    Run Keyword And Continue On Failure    Run Tests    backend-tests/movies_crud.robot --include smoke
    Run Keyword And Continue On Failure    Run Tests    frontend-tests/login_ui.robot --include smoke
    
    # 2. Testes Funcionais
    Run Keyword And Continue On Failure    Run Tests    backend-tests/auth_advanced.robot --include positive
    Run Keyword And Continue On Failure    Run Tests    backend-tests/movies_crud.robot --include positive
    Run Keyword And Continue On Failure    Run Tests    frontend-tests/login_ui.robot --include positive
    
    # 3. Testes End-to-End
    Run Keyword And Continue On Failure    Run Tests    e2e-tests/user_journey.robot --include critical
    
    # 4. Testes de Performance
    Run Keyword And Continue On Failure    Run Tests    performance-tests/load_testing.robot --include critical
    
    Log To Console    ================================
    Log To Console    🏁 Cinema Test Suite Finalizada

*** Keywords ***
Run Tests
    [Arguments]    ${test_path}
    Log To Console    Executando: ${test_path}
    # Esta keyword seria implementada para executar os testes via linha de comando