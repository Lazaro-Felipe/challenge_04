*** Settings ***
Library    RequestsLibrary
Library    SeleniumLibrary
Library    FakerLibrary
Library    JSONLibrary
Library    DateTime
Resource   ../config/global_config.robot

*** Keywords ***
Setup API Session
    [Documentation]    Cria sessão para testes de API
    Create Session    cinema_api    ${API_BASE_URL}

Login And Get Token
    [Documentation]    Faz login e retorna token JWT
    [Arguments]    ${email}=${VALID_USER_EMAIL}    ${password}=${VALID_USER_PASS}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/login    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['data']['token']}
    RETURN    ${token}

Create Test User
    [Documentation]    Cria usuário de teste com dados aleatórios
    ${fake_name}=    FakerLibrary.Name
    ${fake_email}=    FakerLibrary.Email
    ${password}=    Set Variable    TestPass123!
    ${body}=    Create Dictionary    name=${fake_name}    email=${fake_email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/register    json=${body}    expected_status=any
    RETURN    ${fake_email}    ${password}

Setup Browser
    [Documentation]    Configura browser para testes frontend
    Open Browser    ${FRONTEND_URL}    ${BROWSER}
    Set Window Size    1920    1080
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}

Measure Response Time
    [Documentation]    Mede tempo de resposta de requisição
    [Arguments]    ${method}    ${endpoint}    ${data}=${None}
    ${start_time}=    Get Current Date    result_format=epoch
    Run Keyword If    '${method}' == 'GET'    GET On Session    cinema_api    ${endpoint}
    ...    ELSE IF    '${method}' == 'POST'    POST On Session    cinema_api    ${endpoint}    json=${data}
    ${end_time}=    Get Current Date    result_format=epoch
    ${response_time}=    Evaluate    (${end_time} - ${start_time}) * 1000
    RETURN    ${response_time}

Take Screenshot On Failure
    [Documentation]    Captura screenshot em caso de falha
    Run Keyword If Test Failed    Capture Page Screenshot    failure-{index}.png