*** Settings ***
Library    RequestsLibrary
Resource   ../config/global_config.robot
Resource   ../utils/custom_keywords.robot
Test Setup    Setup API Session
Test Teardown    Delete All Sessions

*** Test Cases ***
CT001 - Registro de Usuário
    [Documentation]    Teste obrigatório - POST /api/v1/auth/register
    [Tags]    obrigatorio    auth
    ${body}=    Create Dictionary    
    ...    name=Test User    
    ...    email=testuser@example.com    
    ...    password=password123
    ${response}=    POST On Session    cinema_api    /auth/register    json=${body}    expected_status=any
    Should Be True    ${response.status_code} in [200, 201, 409]
    Should Be True    ${response.json()['success']} or 'already exists' in '${response.json()['message']}'

CT002 - Login de Usuário
    [Documentation]    Teste obrigatório - POST /api/v1/auth/login
    [Tags]    obrigatorio    auth
    ${body}=    Create Dictionary    
    ...    email=user@example.com    
    ...    password=password123
    ${response}=    POST On Session    cinema_api    /auth/login    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be True    ${response.json()['success']}
    Should Contain    ${response.json()}    token

CT003 - Listar Todos os Filmes
    [Documentation]    Teste obrigatório - GET /api/v1/movies
    [Tags]    obrigatorio    movies
    ${response}=    GET On Session    cinema_api    /movies
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be True    ${response.json()['success']}
    Should Contain    ${response.json()}    data
    Should Be True    len(${response.json()['data']}) > 0

CT004 - Obter Filme por ID
    [Documentation]    Teste obrigatório - GET /api/v1/movies/:id
    [Tags]    obrigatorio    movies
    # Primeiro pegar lista de filmes
    ${movies_response}=    GET On Session    cinema_api    /movies
    ${movie_id}=    Set Variable    ${movies_response.json()['data'][0]['_id']}
    
    # Buscar filme específico
    ${response}=    GET On Session    cinema_api    /movies/${movie_id}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be True    ${response.json()['success']}
    Should Be Equal    ${response.json()['data']['_id']}    ${movie_id}

CT005 - Obter Usuário Atual (Autenticado)
    [Documentation]    Teste obrigatório - GET /api/v1/auth/me
    [Tags]    obrigatorio    auth
    # Login primeiro
    ${login_body}=    Create Dictionary    email=user@example.com    password=password123
    ${login_response}=    POST On Session    cinema_api    /auth/login    json=${login_body}
    ${token}=    Set Variable    ${login_response.json()['data']['token']}
    
    # Obter perfil
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema_api    /auth/me    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be True    ${response.json()['success']}
    Should Contain    ${response.json()['data']}    email