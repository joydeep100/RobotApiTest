***Settings***
Resource    ../common/library_imports.robot
Resource    ../common/variables.robot

Test Template     Method Switcher

*** Test Case ***
When i initiate a {method} request to ${params} i should see ${resp_code} and ${resp_body}
# if test name is empty the data file then the test name
# mentioned here is over ridden in the report

***** *Keywords* *****
METHOD SWITCHER
    [Arguments]    ${method}    ${params}    ${resp_code}    ${resp_body}
    ${method_type}  convert to lowercase    ${method}
    run keyword if      '${method_type}'=='get'   INVOKE GET VALIDATOR    ${params}    ${resp_code}    ${resp_body}
    # run keyword if      '${method_type}'=='get'   INVOKE GET VALIDATOR    ${params}    ${resp_code}    ${resp_body}

INVOKE GET VALIDATOR
    [Arguments]     ${params}    ${resp_code}    ${resp_body}
    Create Session      app     ${base_url}     verify=true   #'verify' is needed to aviod a SSL warn msg
    ${resp}     Get Request    app      /api/${params}
    Status Should Be    ${resp_code}    ${resp}
    log dictionary      ${resp.json()}
    # dictionary should contain item      ${resp.json()}      page    1

