Feature: restaurant logs in eMenu
	
	As a restaurant/restaurant chain
	I should be able to sign in
	So that I get access to protectedsections and I can create an manage my menus

	Background:
		When I am not logged in
		Then I navigate to the sign in page

	Scenario: Restaurant is not signed up
		Given I do not have a user
		When I sign in with valid credentials
		Then I should see "Correo o contraseña inválidos"
		And I am signed out

	Scenario: Restaurant signs in successfully
		Given I have a user account
		When I sign in with valid credentials
		Then I should be on the user page
		And I should see "¡Bienvenido a eMenu!"
		And I am signed in

	Scenario: Restaurant enters wrong email
		Given I have a user account
		When I sign in with wrong email
		Then I should see "Correo o contraseña inválidos"
		And I am signed out

	Scenario: Restaurant enters wrong password
		Given I have a user account
		When I sign in with wrong password
		Then I should see "Correo o contraseña inválidos"
		And I am signed out
