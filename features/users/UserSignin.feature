Feature: User Sign in

	As a user,
	I want to be able to sign in,
	So that I can access my account

Background: Registered but not authenticated user
	Given I am a registered user
	Given I am not authenticated

Scenario: User sign in from homepage Sign In button
	Given I am on the SmartCast home page
	When I follow "Sign In"
	Then I should be on the Sign In page

Scenario: User sign in with email (happy path)
	Given I am on the Sign In page
	When I sign in with valid email and password
	Then I should be on the SmartCast home page
	And I should see "Signed in successfully"

Scenario: User sign in with username (happy path)
	Given I am on the Sign In page
	When I sign in with valid username and password
	Then I should be on the SmartCast home page
	And I should see "Signed in successfully"

Scenario: Failed sign in (sad path)
	Given I am on the Sign In page
	When I sign in with invalid credentials
	Then I should see an error message
