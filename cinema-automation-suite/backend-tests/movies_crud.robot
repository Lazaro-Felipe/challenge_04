*** Settings ***
Library    RequestsLibrary
Library    FakerLibrary
Resource   ../utils/custom_keywords.robot
Resource   ../config/global_config.robot
Test Setup    Setup API Session
Test Teardown    Delete All Sessions

*** Test Cases ***
Listar Todos os Filmes
    [Tags]    movies    positive    smoke
    ${response}=    GET On Session    cinema_api    /movies
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be True    ${response.json()['success']}
    ${count}=    Get Length    ${response.json()['data']}
    Should Be True    ${count} > 0
    Log To Console    Total de filmes: ${count}

Buscar Filme por ID
    [Tags]    movies    positive
    ${response}=    GET On Session    cinema_api    /movies
    ${movie_id}=    Set Variable    ${response.json()['data'][0]['_id']}
    ${response}=    GET On Session    cinema_api    /movies/${movie_id}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal    ${response.json()['data']['_id']}    ${movie_id}

Filtrar Filmes por Gênero
    [Tags]    movies    filter    positive
    ${response}=    GET On Session    cinema_api    /movies    params=genre=Action
    Should Be Equal As Strings    ${response.status_code}    200
    FOR    ${movie}    IN    @{response.json()['data']}
        Should Contain    ${movie['genres']}    Action
    END

Criar Novo Filme (Admin)
    [Tags]    movies    admin    positive
    [Documentation]    Teste requer permissões de admin
    ${token}=    Login And Get Token    ${ADMIN_EMAIL}    ${ADMIN_PASS}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    
    ${fake_title}=    FakerLibrary.Sentence    nb_words=3
    ${movie_data}=    Create Dictionary
    ...    title=${fake_title}
    ...    synopsis=Filme de teste automatizado
    ...    director=Test Director
    ...    genres=["Test", "Automation"]
    ...    duration=120
    ...    classification=PG-13
    ...    releaseDate=2024-01-01
    
    ${response}=    POST On Session    cinema_api    /movies    json=${movie_data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    Should Be True    ${response.json()['success']}

Validar Campos Obrigatórios na Criação
    [Tags]    movies    validation    negative
    ${token}=    Login And Get Token    ${ADMIN_EMAIL}    ${ADMIN_PASS}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    
    # Título vazio
    ${movie_data}=    Create Dictionary    title=    synopsis=Test
    ${response}=    POST On Session    cinema_api    /movies    json=${movie_data}    headers=${headers}    expected_status=400
    Should Be Equal As Strings    ${response.status_code}    400

Teste de Performance - Listagem de Filmes
    [Tags]    movies    performance
    ${response_time}=    Measure Response Time    GET    /movies
    Should Be True    ${response_time} < ${MAX_RESPONSE_TIME}
    Log To Console    Tempo de resposta: ${response_time}ms