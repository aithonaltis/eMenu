class MenuItem
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  field :price, :type => BigDecimal
  belongs_to :item_type
end
