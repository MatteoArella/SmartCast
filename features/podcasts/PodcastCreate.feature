@podcast_create
Feature: Create a new podcast

	As an Artist user,
	I want to create new podcast,
	So that my audience can watch to my podcast episodes.

Background: Artist user sign in
	Given I am signed in as an artist user

Scenario: Create podcast from homepage
	Given I am on the SmartCast homepage
	When I follow on "Create Podcast"
	Then I should be on the Create Podcast page