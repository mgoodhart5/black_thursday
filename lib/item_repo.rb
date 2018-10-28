require 'CSV'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemRepo
  attr_reader :all

  def initialize(item_data)
    @all = item_data
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_highest_id
     current_highest = @all.max_by do |item|
       item.id
     end
     current_highest.id
  end

  def create(attributes)
   new_id = find_highest_id + 1
   attributes[:id] = new_id
   @all << new_item = Item.new(attributes)
   new_item
  end

  def update(id, attributes)
    single_item = find_by_id(id)
     if single_item
       single_item.name = attributes[:name] if attributes[:name]
       single_item.description = attributes[:description] if attributes[:description]
       single_item.unit_price = attributes[:unit_price] if attributes[:unit_price]
       single_item.updated_at = Time.now
     end
     single_item
  end

  def delete(id)
    @all.delete_if do |item|
      item.id == id
    end
  end

end
