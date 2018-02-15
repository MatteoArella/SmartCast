Feature: User Sign in

	As a user,
	I want to be able to sign in,
	So that I can access my account

Background: Not authenticated user
	Given I am not authenticated

# sign in
Scenario: User sign in from homepage Sign In button
	Given I am on the SmartCast home page
	When I follow "Sign In"
	Then I should be on the Sign In page

Scenario: User sign in from Sign In page
	Given I am on the Sign In page
	When I follow "Sign up"
	Then I should be on the Sign Up page

Scenario: Artist Sign up (happy path)
	Given I am not authenticated
  When I go to the Sign Up page
  And I fill in "Username" with "dummyUsername"
  And I fill in "user_email" with "testing@man.net"
  And I fill in "user_password" with "secretpass"
  And I fill in "user_password_confirmation" with "secretpass"
  And I press "artist" radio button
  And I press "Sign up"
  Then I should be on the SmartCast home page
  Then I should see "You have signed up successfully"