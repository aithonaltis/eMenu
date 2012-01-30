class ItemType
  include Mongoid::Document
  field :name, localize: true
  has_many :menu_items
end
