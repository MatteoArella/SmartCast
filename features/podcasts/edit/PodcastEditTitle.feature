@podcast_edit
Feature: Change podcast title

	As an Artist user,
	I want to be able to change my podcasts’ title,
	So that I can manage my podcasts.

Background:
	Given the following users exists:
		| email            | password   | type       |
		| admin@test.com   | "password"	| admin      |
		| artist@test.com  | "password"	| artist 	 	 |
		| learner@test.com | "password"	| learner    |

Scenario: Podcast author change Podcast title
	Given my podcast exists
	Given I am signed in with "artist@test.com" email and "password" password
	Given I am on my podcast page
	