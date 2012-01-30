module MenuItemsHelper
  def type_name( item_type )
    item_type.nil? ? "---" : item_type.name
  end
end
