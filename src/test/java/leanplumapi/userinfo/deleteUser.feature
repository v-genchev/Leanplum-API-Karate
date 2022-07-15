@ignore
Feature: Delete User Callable
  Background:
    * configure headers = { 'Accept': 'application/json'}
    * url baseUrl
    * def userId = typeof userId == 'undefined' ? 'testUsered53adb0-c065-4507-bad6-a1e5d89bee00' : userId
    * def deleteUserRequest = {appId:'#(appId)', clientKey:'#(devKey)', apiVersion: '#(apiVersion)', userId: '#(userId)'}

  Scenario: Delete single user
     Given param action = 'deleteUser'
     And request deleteUserRequest
     When method POST
     Then status 200
     And match $.response[0].success == true