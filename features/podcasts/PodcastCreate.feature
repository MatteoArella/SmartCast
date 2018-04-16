@podcast_create
Feature: Create a new podcast

	As an Artist user,
	I want to create new podcast,
	So that my audience can watch to my podcast episodes.

Scenario: Sign In before Create Podcast
	Given I am not authenticated
	Given I am on the SmartCast homepage
	When I follow "Create Podcast" within "#welcome-buttons-bar"
	Then I should be on the Sign In page

Scenario Outline: Learner and Admin cannot Create Podcast
	Given I am signed in as a <role> user
	Given I am on the SmartCast homepage
	Then I should not see "Create Podcast"

	Examples:
		| role    |
		| learner |
		| admin   |

Scenario: Create podcast from homepage
	Given I am signed in as an artist user
	Given I am on the SmartCast homepage
	When I follow "Create Podcast" within "#welcome-buttons-bar"
	Then I should be on the Create Podcast page


