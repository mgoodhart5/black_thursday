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

  

end
