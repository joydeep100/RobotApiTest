*** Test Cases ***
MultiOl
        :for    ${i}    in range    10
        \       log to console      ${i}
        \       exit for loop if    ${i}==2