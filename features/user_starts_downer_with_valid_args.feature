Feature: user starts downer

  As a user
  I want to start downer
  So that I can download a list of files
  
  Scenario: start downer
    Given I have not started application
    When I start a new application with valid arguments
    Then I should see "Starting download on 4 files"