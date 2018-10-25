require 'CSV'
require_relative '../lib/item'


class ItemRepo
  attr_reader :all

  def initialize(item_data)
    @all = []
    create_items(item_data)
  end

  def create_items(item_data)
    things = CSV.read(item_data, headers: true, header_converters: :symbol)
    @all = things.map do |thing|
      Item.new(thing)
    end
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
    @all.find_all
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
   Item.new(attributes)
  end

  def update(id, attributes)
    @all.find do |item|
      if item.id == id
        item.name.replace(attributes[:name])
        item.description.replace(attributes[:description])
        item.unit_price.replace(attributes[:unit_price])
      end
    end
  end

  def delete(id)
    @all.delete_if do |item|
      item.id == id
    end
  end













end
