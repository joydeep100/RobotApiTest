# RobotApiTest
A Data Driven framework for RESTFUL API Testing using Robot Framework.

## How it works
Put all your Test Cases inside the `test_data.xlsx` file.

![Sample test data file screenshot](sample_reports/Excel.jpg?raw=true)

## Pre-Conditions 
- Python3

## Installation steps
1. Go to the project root
2. run the command ```pip install -r requirement.txt``` as Admininstrator or root.

## Executing Tests
- run the command ``` robot test_scripts/data_driven_tests.robot``` 

## Debug a single/ selected tests
1. make the `${DEBUG MODE}` variable as `'Y'` in the test script file.
2. for all the tests where you need to run, ust mention `${debug_flag}` row value as `'Y'` in `test_data.xlsx` file

## TestData file inputs
All the fiels are self explanatory
- for `${req_body}` give the expected json (if any)
- for validating the response body value, given new line separated nested key names. for example,
  Assume this is the reponse json.
    ```"{
    "name": "morpheus",
    "job": {
             "title": "leader"
             }
    }"
and you want to validate values of 'name' and 'job.title' keys,
Give the data as.
```
['name']=morpheus
['job']['title']=leader
