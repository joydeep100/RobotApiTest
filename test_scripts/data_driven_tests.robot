***Settings***
Resource    ../common/library_imports.robot
Resource    ../common/variables.robot
Test Template     RESTFUL SERVICE SWITCHER
Suite Setup     Create Session      app     ${base_url}     verify=true     #'verify' is needed to aviod a SSL warn msg

*** Variables ***
${DEBUG MODE}    N  # (Y|N)

*** Test Cases ***
Test Template Arguments :: {method},${query_params},${resp_code},${req_body},${resp_body},${debug_flag}
# note, This is just a test template
# All test cases are defined in test_data.xlsx file.

***** *Keywords* ***
RESTFUL SERVICE SWITCHER
    [Arguments]    ${method}    ${query_params}    ${resp_code}    ${req_body}    ${resp_body}   ${debug_flag}

    run keyword if      '${DEBUG MODE}'=='Y'    ENABLE DEBUGGER      ${debug_flag}

    ${method_type}  convert to lowercase    ${method}
    @{args}     create list     ${query_params}    ${resp_code}    ${req_body}    ${resp_body}

    run keyword if      '${method_type}'=='get'   GET VALIDATOR     @{args}
    run keyword if      '${method_type}'=='post'   POST VALIDATOR    @{args}
    run keyword if      '${method_type}'=='put'   PUT VALIDATOR    @{args}
    run keyword if      '${method_type}'=='patch'   PATCH VALIDATOR    @{args}
    run keyword if      '${method_type}'=='delete'   DELETE VALIDATOR    @{args}

RESPONSE BODY PARSER AND VALIDATOR
    [Arguments]     ${resp_body}    ${server_response_json}

    @{items}    split string    ${resp_body}    \n   -1
    :FOR    ${i}    IN  @{items}
    \   @{item}    split string    ${i}    =
    \   ${key}    set variable    ${server_response_json${item[0]}}
    \   ${key_str}    convert to string   ${key}
    \   should be equal     ${key_str}     ${item[1]}

ENABLE DEBUGGER
    [Arguments]      ${debug_flag}

    pass execution if   '${debug_flag}'!='Y'   Skipping Test
    # [DEBUG MODE]:: We can use the above line when we want to run only a few selected tests
    # just mention ${debug_flag} row value as 'Y' in test_data.xlsx file

GET VALIDATOR
    [Arguments]     ${query_params}    ${resp_code}    ${req_body}    ${resp_body}

    ${resp}     Get Request    app      /api/${query_params}
    Status Should Be    ${resp_code}    ${resp}
    ${len}      get length      ${resp_body}
    run keyword if    ${len}>=1     RESPONSE BODY PARSER AND VALIDATOR     ${resp_body}    ${resp.json()}

POST VALIDATOR
    [Arguments]     ${query_params}    ${resp_code}    ${req_body}    ${resp_body}

    ${resp}     Post Request    app      /api/${query_params}      ${req_body}
    Status Should Be    ${resp_code}    ${resp}
    ${len}      get length      ${resp_body}
    run keyword if    ${len}>=1     RESPONSE BODY PARSER AND VALIDATOR     ${resp_body}    ${resp.json()}

PUT VALIDATOR
    [Arguments]     ${query_params}    ${resp_code}    ${req_body}    ${resp_body}

    ${resp}     Put Request    app      /api/${query_params}      ${req_body}
    Status Should Be    ${resp_code}    ${resp}
    ${len}      get length      ${resp_body}
    run keyword if    ${len}>=1     RESPONSE BODY PARSER AND VALIDATOR     ${resp_body}    ${resp.json()}

PATCH VALIDATOR
    [Arguments]     ${query_params}    ${resp_code}    ${req_body}    ${resp_body}

    ${resp}     Patch Request    app      /api/${query_params}      ${req_body}
    Status Should Be    ${resp_code}    ${resp}
    ${len}      get length      ${resp_body}
    run keyword if    ${len}>=1     RESPONSE BODY PARSER AND VALIDATOR     ${resp_body}    ${resp.json()}

DELETE VALIDATOR
    [Arguments]     ${query_params}    ${resp_code}    ${req_body}    ${resp_body}

    ${resp}     Delete Request    app      /api/${query_params}
    Status Should Be    ${resp_code}    ${resp}
