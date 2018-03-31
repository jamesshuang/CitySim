class PluralConverter
  
  def pluralize item_count, item
    if item_count > 1 or item_count == 0
      if item[-1] == "s"
        item + "es"
      else 
        item + "s"
      end
    else
      item
    end
  end
  
end