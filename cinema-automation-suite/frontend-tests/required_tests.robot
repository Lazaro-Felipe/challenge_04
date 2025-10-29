*** Settings ***
Library    SeleniumLibrary
Resource   ../config/global_config.robot
Test Setup    Open Browser    ${FRONTEND_URL}    Chrome    options=add_argument("--disable-web-security")
Test Teardown    Close Browser

*** Test Cases ***
CT001 - Verificar Carregamento da Aplicação
    [Documentation]    Teste obrigatório - Verificar se a aplicação carrega
    [Tags]    obrigatorio    smoke
    Wait Until Page Contains Element    xpath=//body    10s
    Page Should Not Contain    Error

CT002 - Verificar Formulário de Login
    [Documentation]    Teste obrigatório - Verificar elementos do login
    [Tags]    obrigatorio    login
    Wait Until Page Contains Element    xpath=//input    10s
    Page Should Contain Element    xpath=//input[@type='email' or contains(@placeholder,'email')]
    Page Should Contain Element    xpath=//input[@type='password' or contains(@placeholder,'password')]

CT003 - Verificar Botão de Ação
    [Documentation]    Teste obrigatório - Verificar botão principal
    [Tags]    obrigatorio    ui
    Wait Until Page Contains Element    xpath=//button    10s
    Element Should Be Enabled    xpath=//button[1]