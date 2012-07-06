# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :menu_item do
  	name 'Test Menu Item'
  	description 'test item'
  	price 100.00
  end
end