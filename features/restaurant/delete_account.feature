Feature: Edit Restaurant account
	
	As a registered restaurant on eMenu
	I want to cancel my account
	in order to delete my data from eMenu

	Background:
		Given I have a user account
		Then I navigate to the sign in page
		And I sign in user
		Then I am signed in
    	And I go to the edit user page

    @javascript
    Scenario: I delete my account
    	When I follow "delete_account"
    	And I confirm popup
    	And I should see "Su cuenta fue cancelada con éxito"

    @javascript
    Scenario: By mistake I click delete account
    	When I follow "delete_account"
    	And I dismiss popup
    	Then I should be on the edit user page
