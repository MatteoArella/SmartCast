Feature: Artist Sign up

	As an Artist user,
	I want to sign up,
	So that I can create new podcasts

# sign up 
Scenario: Artist Sign up from homepage Sign In button
	Given I am on the SmartCast home page
	When I follow "Sign In"
	Then I should be on the Sign In page
	And I should see "Sign Up"

Scenario: Artist Sign up from Sign In page
	Given I am on the Sign In page
	When I follow "Sign Up"
	Then I should be on the "Sign Up" page

Scenario: Artist Sign up (happy path)
	Given I am not authenticated
  When I go to Sign up page
  And I fill in "Username" with "dummyUsername"
  And I fill in "user_email" with "testing@man.net"
  And I fill in "user_password" with "secretpass"
  And I fill in "user_password_confirmation" with "secretpass"
  And I check "artist" # artist role
  And I press "Sign up"
  Then I should be on the SmartCast home page
  Then I should see "logged in as testing@man.net"