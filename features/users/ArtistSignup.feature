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