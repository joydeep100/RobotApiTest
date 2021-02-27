***Settings***
Library    SeleniumLibrary

*** Variables ***
${url}    http://temp.cargofl.com/cloud

*** Test Cases ***
TestCase1
    open browser    ${url}  gc
    Select text from DropDown      //span[@title='Please Select Branch/Depot']      //li[@class='select2-results__option']      Bhosari

    Select text from DropDown      //span[@title='Please Select Department']      //li[@class='select2-results__option']      Traffic

    sleep   10
    close all browsers


*** Keywords ***
Select text from DropDown
    [Arguments]    ${DropDown_selector}    ${DropDown_elements_selector}    ${item_to_be_selected}
    click element   ${DropDown_selector}
    ${all_elements}     Get WebElements       ${DropDown_elements_selector}

    :for     ${element}      in      @{all_elements}
        \   ${item_text}    get text    ${element}
        \   log to console      ${item_text}
        \   run keyword if      '${item_text}'=='${item_to_be_selected}'    run keywords    click element   ${element}    AND     exit for loop



