@omniauth_test @sign_up
Feature: User sign up with Facebook

	As an user,
	I want to be able to sign up with Facebook,
	So that I can share informations about my Facebook account with SmartCast

Background: Not authenticated user
	Given I am not authenticated

Scenario Outline: User sign up with Facebook
	Given I am on the Sign up page
	When I follow "Sign Up with Facebook"
	Then I should be on the role selection page
	When I press <role> radio button
	And I press "Sign Up with Facebook"
	Then I should be on the SmartCast homepage
	And I should see "Successfully Signed Up with Facebook"
	
	Examples:
		| role 			|
		| "artist" 	|
		| "learner" |