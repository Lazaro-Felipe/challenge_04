*** Settings ***
Library    SeleniumLibrary
Resource   ../config/global_config.robot
Test Setup    Open Browser    ${FRONTEND_URL}    ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
Verificar Página Carrega
    [Tags]    frontend    smoke
    Page Should Contain    Cinema
    
Verificar Elementos Existem
    [Tags]    frontend    ui
    Page Should Contain Element    css=input
    Page Should Contain Element    css=button

Teste de Navegação Básica
    [Tags]    frontend    navigation
    Get Title
    Get Location
    Log To Console    Página carregada com sucesso