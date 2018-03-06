@omniauth_test @sign_up
Feature: User sign up with Facebook

	As an user,
	I want to be able to sign up with Facebook,
	So that I can share informations about my Facebook account with SmartCast

Background: Not authenticated user
	Given I am not authenticated

@artist
Scenario Outline: Artist sign up with Facebook from Sign up page
	Given I am on the Sign up page
	When I follow "Sign Up with Facebook"
	Then I should be on the role selection page
	And I click on <role> radio button
	And I follow "Sign up"
	Then I should be on the SmartCast homepage
	And I should see a success message
	
	Examples:
		| role 		|
		| artist 	|
		| learner |