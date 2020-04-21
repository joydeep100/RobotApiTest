***Settings***
Resource    ../common/library_imports.robot
Resource    ../common/variables.robot

Test Template     METHOD SWITCHER

*** Test Case ***
Validating a {method} request with ${params}, i should see ${resp_code} and ${resp_body}, [DEBUG MODE]::${failure_tag}

***** *Keywords* *****
METHOD SWITCHER
    [Arguments]    ${method}    ${params}    ${resp_code}    ${resp_body}   ${failure_tag}

    # pass execution if   '${failure_tag}'!='Y'   Skipping Test

    # HACK [DEBUG MODE]:: We can use the above line when we want to run only a selected tests
    # just mention ${failure_tag} as 'Y' in test_data.xlsx file

    ${method_type}  convert to lowercase    ${method}
    run keyword if      '${method_type}'=='get'   INVOKE GET VALIDATOR    ${params}    ${resp_code}    ${resp_body}


INVOKE GET VALIDATOR
    [Arguments]     ${params}    ${resp_code}    ${resp_body}
    Create Session      app     ${base_url}     verify=true   #'verify' is needed to aviod a SSL warn msg
    ${resp}     Get Request    app      /api/${params}
    Status Should Be    ${resp_code}    ${resp}
    log dictionary      ${resp.json()}
    # dictionary should contain item      ${resp.json()}      page    1

