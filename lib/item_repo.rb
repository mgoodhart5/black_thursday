require_relative '../lib/item'
require_relative '../lib/sales_engine'
require_relative '../lib/method_module'

class ItemRepo
  include FindMethods

  attr_reader :all

  def initialize(item_data)
    @all = item_data
    @first_step = first_step
    @sum = sum
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

  def average_item_price
    item_price_sum = @all.inject(BigDecimal.new(0)) do |sum, item|
      sum + item.unit_price
    end
    item_price_sum / BigDecimal.new(@all.length)
  end

  def first_step
    @first_step = @all.map do |item|
      answer = (item.unit_price - average_item_price)
      answer * answer
    end
  end

  def sum
    answer = 0
    @first_step.each do |number|
      answer += number
    end
    answer
  end

  def item_price_standard_deviation
    final_step = @sum / ((@all.length.to_f) - 1)
    Math.sqrt(final_step.to_f).round(2)
  end

end
