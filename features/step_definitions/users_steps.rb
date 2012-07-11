
Given /^I am not logged in$/ do
  destroy_user_session_path
end

When /^I request an invitation with an existent email$/ do
  user = FactoryGirl.create(:user)
  steps %Q{
  		When I fill in the following:
			| name | #{user.name} |
			| email | #{user.email} |
			| password | #{user.password} |
			| password_confirmation | #{user.password_confirmation} |
    When I press "Guardar"
  }
end

Then /^I should see an existent email message$/ do
  step %{I should see "en uso"}
end