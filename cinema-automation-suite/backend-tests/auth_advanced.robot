*** Settings ***
Library    RequestsLibrary
Resource   ../utils/custom_keywords.robot
Resource   ../config/global_config.robot
Test Setup    Setup API Session
Test Teardown    Delete All Sessions

*** Test Cases ***
Registro de Usuário com Dados Válidos
    [Tags]    auth    positive    smoke
    ${email}    ${password}=    Create Test User
    Log To Console    Usuário criado: ${email}

Login com Token JWT Válido
    [Tags]    auth    positive    security
    ${token}=    Login And Get Token
    Should Not Be Empty    ${token}
    Log To Console    Token obtido com sucesso: ${token[:20]}...

Teste de Login Válido
    [Tags]    auth    security    positive
    ${response}=    POST On Session    cinema_api    /auth/login    
    ...    json={"email": "test@example.com", "password": "password123"}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be True    ${response.json()['success']}

Tentativa de Login com Força Bruta
    [Tags]    auth    security    negative
    FOR    ${i}    IN RANGE    3
        ${response}=    POST On Session    cinema_api    /auth/login    
        ...    json={"email": "${VALID_USER_EMAIL}", "password": "wrong${i}"}    expected_status=any
        Should Be True    ${response.status_code} in [401, 500]
    END

Validação de Email Inválido
    [Tags]    auth    validation    negative
    ${response}=    POST On Session    cinema_api    /auth/login    
    ...    json={"email": "invalid-email", "password": "password123"}    expected_status=any
    Should Be True    ${response.status_code} in [400, 401, 500]