Feature: restaurant signs up in pMenu

	As a restaurant/restaurant chain
	I want to create an account in pMenu
	So that I can create my menu in pMenu

	Background:
		Given I am not logged in
		When I am on the home page
		And I follow "sign_up"

	Scenario: sign up with valid data
		When I fill in the following:

			| name | Restaurante Perruno |
			| email | can@perrunos.com |
			| password | algunPassword |
			| password_confirmation | algunPassword |

		#And I attach the file "~pMenu/logo.jpg" to "Logo" #Imagen en pMenu home del usuario
		And I press "Guardar"
		And I should be on the home page
		And I should see "¡Bienvenido! Tu cuenta se ha creado correctamente"

	Scenario: User signs up with existent email
	    When I request an invitation with an existent email
	    Then I should see an existent email message