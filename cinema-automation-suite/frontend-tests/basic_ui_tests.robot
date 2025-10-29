*** Settings ***
Library    SeleniumLibrary
Resource   ../config/global_config.robot
Test Setup    Open Browser    ${FRONTEND_URL}    Chrome
Test Teardown    Close Browser

*** Test Cases ***
CT001 - Verificar Conexão com Frontend
    [Documentation]    Teste obrigatório - Verificar se consegue conectar
    [Tags]    obrigatorio    smoke
    ${title}=    Get Title
    Log To Console    Título da página: ${title}
    ${url}=    Get Location
    Should Contain    ${url}    3002

CT002 - Verificar Página Responde
    [Documentation]    Teste obrigatório - Verificar se página não está vazia
    [Tags]    obrigatorio    response
    ${source}=    Get Source
    Should Not Be Empty    ${source}
    Should Not Contain    ${source}    Cannot GET

CT003 - Verificar Elementos HTML Básicos
    [Documentation]    Teste obrigatório - Verificar estrutura HTML básica
    [Tags]    obrigatorio    html
    Page Should Contain Element    xpath=//html
    Page Should Contain Element    xpath=//body
    Page Should Contain Element    xpath=//head