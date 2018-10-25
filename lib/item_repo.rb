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

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end











end
