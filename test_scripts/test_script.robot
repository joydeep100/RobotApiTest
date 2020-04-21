***Settings***
Resource    ../common/library_imports.robot
Resource    ../common/variables.robot

Test Template     METHOD SWITCHER

Suite Setup     Create Session      app     ${base_url}     verify=true
#'verify' is needed to aviod a SSL warn msg

*** Test Cases ***
Validating a {method} request with ${params}, i should see ${resp_code} and ${resp_body}, [DEBUG MODE]::${failure_tag}
# note, All test cases are defined in test_data.xlsx file.

***** *Keywords* ***
METHOD SWITCHER
    [Arguments]    ${method}    ${params}    ${resp_code}    ${resp_body}   ${failure_tag}

    # *** HACK ***
    # pass execution if   '${failure_tag}'!='Y'   Skipping Test
    # [DEBUG MODE]:: We can use the above line when we want to run only a few selected tests
    # just mention ${failure_tag} row value as 'Y' in test_data.xlsx file

    ${method_type}  convert to lowercase    ${method}
    run keyword if      '${method_type}'=='get'   INVOKE GET VALIDATOR    ${params}    ${resp_code}    ${resp_body}


INVOKE GET VALIDATOR
    [Arguments]     ${params}    ${resp_code}    ${resp_body}

    ${resp}     Get Request    app      /api/${params}
    Status Should Be    ${resp_code}    ${resp}
    ${len}      get length      ${resp_body}
    run keyword if    ${len}>=1     RESPONSE BODY PARSER AND VALIDATOR     ${resp_body}    ${resp.json()}

RESPONSE BODY PARSER AND VALIDATOR
    [Arguments]     ${resp_body}    ${resp.json()}
    @{items}    split string    ${resp_body}    ,   -1
    :FOR    ${i}    IN  @{items}
    \   @{item}    split string    ${i}    =
    \   dictionary should contain item      ${resp.json()}      @{item}

