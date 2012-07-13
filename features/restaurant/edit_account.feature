Feature: Edit Restaurant account
	
	As a registered restaurant on eMenu
	I want to edit my restaurant profile
	so I can change my data account

	Background:
		Given I have a user account
		Then I navigate to the sign in page
		And I sign in user
		Then I am signed in
    	And I go to the edit user page

    Scenario: I edit all my account data
		When I edit all my account details
		Then I should see "Usted actualizó su cuenta exitosamente."

    Scenario: I edit only my user name
    	When I edit my "name"
    	Then I should see "Usted actualizó su cuenta exitosamente."

    Scenario: I edit and enter wrong current password
    	When I edit my account with wrong "current password"
    	Then I should see "La contraseña actual no coincide"

    Scenario: I edit and enter wrong password confirmation
    	When I edit my account with wrong "password confirmation"
    	Then I should see "Confirma tu contraseña"

    Scenario: I edit and enter wrong email
    	When I edit my account with wrong "email"
    	Then I should see "Email Formato de email incorrecto"
