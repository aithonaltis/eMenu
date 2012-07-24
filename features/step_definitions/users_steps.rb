
def create_visitor
  @visitor ||= { :name => "Person 1", :email => "example@example.com",
    :password => "foobar", :password_confirmation => "foobar", current_password: "foobar" }
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email])
end

def delete_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
  @user.destroy unless @user.nil?
end

###### Given

Given /^I am not logged in$/ do
  destroy_user_session_path
end

Given /^I have a user account$/ do
  create_user
end

Given /^I do not have a user$/ do
  create_visitor
  delete_user
end

###### When

When /^I sign up with valid data$/ do
  user = FactoryGirl.create(:user)
  steps %Q{
      When I fill in the following:
      | name | #{user.name} |
      | email | example1@emenu.com |
      | password | #{user.password} |
      | password_confirmation | #{user.password_confirmation} |
      When I press "Guardar"
    }
end

When /^I sign up with "(.*?)"$/ do |field|
  @user = FactoryGirl.create(:user)
  if field == 'existent email'
    @user.email == 'person@hotmail.com'
  elsif field == 'invalid password'
    @user.password, @user.password_confirmation = 'a*80'
  elsif field == 'mismatched password confirmation'
    @user.password_confirmation = 'a' * 7
  end
  step %{I fill and submitt sign up form with user data}
end

When /^I sign up without "(.*?)"$/ do |field|
  @user = FactoryGirl.create(:user)
  if field == 'name'
    @user.name = ''
  elsif field == 'email'
    @user.email = ''
  elsif field == 'password'
    @user.password = ''
  elsif field == 'password confirmation'
    @user.password_confirmation == ''
  end
  step %{I fill and submitt sign up form with user data}
end

When /^I sign up with the image "(.+)" as avatar$/ do |image|
  create_visitor
  steps %Q{
    When I fill in the following:
      | name | #{@visitor[:name]} |
      | email | #{@visitor[:email]} |
      | password | #{@visitor[:password]} |
      | password_confirmation | #{@visitor[:password_confirmation]} |
  }
  step %{I attach the file "#{image}" to "avatar"}
  step %{I press "Guardar"}
end

When /^I fill and submitt sign up form with user data$/ do
  @user ||= FactoryGirl.create(:user)
  steps %Q{
      When I fill in the following:
      | name | #{@user.name} |
      | email | #{@user.email} |
      | password | #{@user.password} |
      | password_confirmation | #{@user.password_confirmation} |
      When I press "Guardar"
    }
end

When /^I navigate to the sign in page$/ do
  steps %Q{
    When I am on the home page
    And I follow "sign_in"
    Then I am on the sign in page
  }
end

When /^I sign in with valid credentials$/ do
  steps %Q{
    When I sign in user
  }
end

When /^I sign in with wrong email$/ do
  @visitor[:email] = "wrong@example.com"
  steps %Q{
    When I sign in user
  }
end

When /^I sign in with wrong password$/ do
  @visitor[:password] = "wrongpass"
  steps %Q{
    When I sign in user
  }
end

When /^I sign in user$/ do
  steps %Q{
    When I fill in the following:
    | email | #{@visitor[:email]} |
    | password | #{@visitor[:password]} |
    And I press "sign_in"
  }
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I edit all my account details$/ do
  @visitor[:name] = "other name"
  @visitor[:password] = @visitor[:password_confirmation] = "newpass"
  step "I edit my account details"
end

When /^I edit my "(.*)"$/ do |field|
  @visitor[:password] = @visitor[:password_confirmation] = ''
  if field == 'name'
    @visitor[:name] = "other name"
  end
  step "I edit my account details"
end

When /^I edit my account with wrong "(.*)"$/ do |field|
  case field
    when /^current\s?password$/
      @visitor[:current_password] = "wrongpass"
    when /^password\s?confirmation$/
      @visitor[:password] = "wrong"
      @visitor[:password_confirmation] = "newpass"
    when /^email$/
      @visitor[:email] = 'notanemail'
    end
  step "I edit my account details"
end

When /^I edit my account details$/ do
  steps %Q{
    When I fill in the following:
    | name | #{@visitor[:name]} |
    | email | #{@visitor[:email]} |
    | password | #{@visitor[:password]} |
    | password_confirmation | #{@visitor[:password_confirmation]} |
    | current_password | #{@visitor[:current_password]} |
    And I press "save"
  }
end

When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept    
end

When /^I dismiss popup$/ do
  page.driver.browser.switch_to.alert.dismiss
end

################### Then 

Then /^I am signed out$/ do
  steps %Q{
    And I should see the link "sign_up"
    Then I should see the link "sign_in"
    And I should not see the link "edit_account"
  }
end

Then /^I am signed in$/ do
  steps %Q{
    Given I am on the home page
    Then I should see the link "edit_account"
    And I should see the link "sign_out"
    And I should not see the link "sign_in"
    And I should not see the link "sign_up"
  }
end

Then /^I should see the link "(.*)"/ do |link|
  page.should have_link(link)
end

Then /^I should not see the link "(.*)"/ do |link|
  page.should_not have_link(link)
end

Then /^I should see the right avatar image$/ do
  created = User.first conditions: {:email => @visitor[:email]}
  page.should have_xpath("//img[contains(@src, \"/uploads/user/image/#{created.id}/profile_icn_default.png\")]")
end

Then /^I should see the default avatar image$/ do
  page.should have_xpath("//img[contains(@src, \"/assets/listing_defaults/profile_default.png\")]")
end