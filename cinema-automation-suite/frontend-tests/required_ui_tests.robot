*** Settings ***
Library    SeleniumLibrary
Resource   ../config/global_config.robot
Test Setup    Open Browser    ${FRONTEND_URL}    Chrome
Test Teardown    Close Browser

*** Test Cases ***
CT001 - Verificar Aplicação Carrega
    [Documentation]    Teste obrigatório - Verificar se a aplicação carrega
    [Tags]    obrigatorio    smoke
    Wait Until Page Contains Element    xpath=//body    10s
    Page Should Not Contain    404
    Page Should Not Contain    Error

CT002 - Verificar Elementos de Input
    [Documentation]    Teste obrigatório - Verificar se existem campos de input
    [Tags]    obrigatorio    ui
    Wait Until Page Contains Element    xpath=//input    10s
    Page Should Contain Element    xpath=//input
    Page Should Contain Element    xpath=//button

CT003 - Verificar Interação Básica
    [Documentation]    Teste obrigatório - Verificar se é possível interagir com elementos
    [Tags]    obrigatorio    interaction
    Wait Until Page Contains Element    xpath=//input    10s
    ${inputs}=    Get WebElements    xpath=//input
    Should Be True    len(${inputs}) >= 2
    Click Element    xpath=//input[1]
    Input Text    xpath=//input[1]    test@example.com