Feature: restaurant signs up in eMenu

	As a restaurant/restaurant chain
	I want to create an account in eMenu
	So that I can create my menu in eMenu

	Background:
		Given I am not logged in
		When I am on the home page
		And I follow "sign_up"

	Scenario: sign up with valid data
		When I sign up with valid data
		And I should be on the home page
		And I should see "¡Bienvenido! Tu cuenta se ha creado correctamente"

	Scenario: Restaurant signs up without name
	    When I sign up without "name"
	    Then I should see "Introduce tu nombre"

	Scenario: Restaurant signs up with existent email
	    When I sign up with "existent email"
	    Then I should see "Email ya está en uso"

	Scenario: Restaurant signs up without password
	    When I sign up without "password"
	    Then I should see "Ingresa una contraseña"

	Scenario: Restaurant signs up with invalid password
		When I sign up with "invalid password"
		Then I should see "Tu contraseña debe ser de mínimo 6 carateres"

	Scenario: Restaurant signs up without password confirmation
	    When I sign up without "password confirmation"
	    Then I should see "Confirma tu contraseña"

	Scenario: Restaurant signs up with mismatched password and confirmation
		When I sign up with "mismatched password confirmation"
		Then I should see "Las contraseñas no coinciden"