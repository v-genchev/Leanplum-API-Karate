# Leanplum-API-Karate [![Leanplum API Tests](https://github.com/v-genchev/Leanplum-API-Karate/actions/workflows/maven.yml/badge.svg)](https://github.com/v-genchev/Leanplum-API-Karate/actions/workflows/maven.yml)
Simple automation framework made using [Karate](https://github.com/karatelabs/karate) for the Leanplum API

## Setup
Clone the project and import the pom.xml

## Test case execution
In order to execute the test cases locally you either need to
1. Update key variables in [karate-config.js](/src/test/java/karate-config.js) with yours and run the tests from the fature file
    ```javascript
    var appId = karate.properties['appId'];
    var prodKey = karate.properties['prodKey'];
    var exportKey = karate.properties['exportKey'];
    var devKey = karate.properties['devKey']
    ```
2. Or you need to execute them through maven, passing the key values as command line arguments
    ```
   mvn clean test -DappId=**** -DprodKey=**** -DexportKey=**** -DdevKey=**** -Dtest=ApiTest
    ```
   
## Test case reports
- For now the project uses the default Karate reporting, you can find it after execution in target/karate-reports.
- All keys are masked from the reports using the MaskingLogModifier.

## Simple Workflow for executing the API test cases

- Triggered on pull request to the main branch and in 23:30 UTC every day
- Karate report is uploaded in the artifacts. Also when you go to the Run Tests job, you could see the report integrated
<img width="929" alt="image" src="https://user-images.githubusercontent.com/61762311/179342030-99f7188f-dda3-4cf5-8756-e9d290b737a5.png">


   

