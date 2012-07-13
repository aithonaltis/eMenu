Feature: restaurant signs out from eMenu

	As a restaurant/ restaurant chain
	I should be able to sign out
	So I can protect my account from unauthorized access

	Background:
		Given I have a user account
		Then I navigate to the sign in page
		And I sign in user
		Then I am signed in

	Scenario: Restaurant signs out
		When I sign out
		Then I am signed out
		And I should see "Hasta pronto"