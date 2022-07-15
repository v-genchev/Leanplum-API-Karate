Feature: Set user attributes

  Background:

    * configure headers = {'Accept': 'application/json'}
    * url baseUrl
    * def testUser = 'testUser' + UUID
    * def setUserAttributesBaseRequest = read('setUserAttributesRequest.json')

    * def initialUserCreationRequest = read('setUserAttributesRequest.json')
    * set initialUserCreationRequest
      | path           | value                                                    |
      | userId         | testUser                                                 |
      | userAttributes | { gender:'M', age: '27', interests:['Hiking', 'Chess'] } |
    Given param action = 'setUserAttributes'
    And request initialUserCreationRequest
    When method POST
    Then status 200
    And match $.response[0].success == true

  Scenario: Change User Attributes Happy Path

    * set setUserAttributesBaseRequest
      | path           | value                     |
      | userId         | testUser                  |
      | userAttributes | { gender:'F', age: '35' } |
    Given param action = 'setUserAttributes'
    And request setUserAttributesBaseRequest
    When method POST
    Then status 200
    And match $.response[0].success == true

    * def expectedUserAttributes = karate.merge(setUserAttributesBaseRequest.userAttributes, {interests: '#(initialUserCreationRequest.userAttributes.interests)'})
    Given params {action: 'exportUser', appId: #(appId), clientKey: #(exportKey), apiVersion: #(apiVersion), userId: #(testUser)}
    When method GET
    Then status 200
    And match $.response[0] contains {userId: #(testUser), userAttributes: #(expectedUserAttributes)}

    * def deleteUser = call read('deleteUser.feature') { userId: '#(testUser)'}

  Scenario: Add User Attributes Happy Path

    * def interestToAdd = 'Books'
    * set setUserAttributesBaseRequest
      | path                     | value                           |
      | userId                   | testUser                        |
      | userAttributeValuesToAdd | { interests: #(interestToAdd) } |
    Given param action = 'setUserAttributes'
    And request setUserAttributesBaseRequest
    When method POST
    Then status 200
    And match $.response[0].success == true

    * def expectedUserAttributes = initialUserCreationRequest.userAttributes
    * set expectedUserAttributes.interests[] = interestToAdd
    Given params {action: 'exportUser', appId: #(appId), clientKey: #(exportKey), apiVersion: #(apiVersion), userId: #(testUser)}
    When method GET
    Then status 200
    And match $.response[0] contains {userId: #(testUser), userAttributes: #(expectedUserAttributes)}

    * def deleteUser = call read('deleteUser.feature') { userId: '#(testUser)'}

  Scenario: Remove User Attributes Happy Path
    * set setUserAttributesBaseRequest
      | path                        | value                  |
      | userId                      | testUser               |
      | userAttributeValuesToRemove | { interests: 'Chess' } |
    Given param action = 'setUserAttributes'
    And request setUserAttributesBaseRequest
    When method POST
    Then status 200
    And match $.response[0].success == true
    And match $.response[0].warning.message == '#notpresent'

    * def expectedUserAttributes = initialUserCreationRequest.userAttributes
    * remove expectedUserAttributes $.interests[?(@ == "Chess")]
    Given params {action: 'exportUser', appId: #(appId), clientKey: #(exportKey), apiVersion: #(apiVersion), userId: #(testUser)}
    When method GET
    Then status 200
    And match $.response[0] contains {userId: #(testUser), userAttributes: #(expectedUserAttributes)}

    * def deleteUser = call read('deleteUser.feature') { userId: '#(testUser)'}


















