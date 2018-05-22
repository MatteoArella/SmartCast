@podcast_create
Feature: Create a new podcast

	As an Artist user,
	I want to create new podcast,
	So that my audience can watch to my podcast episodes.

Scenario Outline: Sign In before Create Podcast
	Given I am not authenticated
	Given I am on the SmartCast homepage
	When I follow "Create Podcast" within <scope>
	Then I should be on the Sign In page

	Examples:
		| scope					 |
		| "#welcome-buttons-bar" |
		| "nav"					 |

Scenario Outline: Learner and Admin cannot Create Podcast
	Given I am signed in as a <role> user
	Given I am on the SmartCast homepage
	Then I should not see "Create Podcast"

	Examples:
		| role    |
		| learner |
		| admin   |

Scenario Outline: Artist Create podcast from homepage
	Given I am signed in as an artist user
	Given I am on the SmartCast homepage
	When I follow "Create Podcast" within <scope>
	Then I should be on the Create Podcast page

	Examples:
		| scope					 |
		| "#welcome-buttons-bar" |	#from homepage links
		| "nav"					 |	#from header navbar

