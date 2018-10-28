require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/merchant'
require 'mathn'
require 'CSV'

class SalesAnalyst

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(next_step).round(2)
  end

  def counted_items
    # rename this method cause WHAT?
    count = []
    @merchants.all.each do |merchant|
      count << @items.find_all_by_merchant_id(merchant.id).count
    end
    count
  end

  def mean_of_merchant_items
    sum = 0
    counted_items.each do |number|
      sum += number
    end
    sum / @merchants.all.count
  end

  def next_step
    # also rename this method
    sum_2 = 0
    counted_items.map do |number|
      answer = (number - mean_of_merchant_items)
      answer * answer
    end.each do |number|
      sum_2 += number
    end
    sum_2 / ((counted_items.count.to_f) - 1)
  end

  def merchants_with_high_item_count
    @merchants.all.find_all do |merchant|
      merchant_items = @items.find_all_by_merchant_id(merchant.id)
      merchant_items.length >= (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_for_merchant(id)
    merchant_items = @items.find_all_by_merchant_id(id)
    price_sum = merchant_items.map do |item|
      item.unit_price
    end.reduce(:+)
    price_sum / BigDecimal.new(merchant_items.length)
  end

  def average_average_price_per_merchant
    merchant_averages = @merchants.all.map do |merchant|
      merchant_items = @items.find_all_by_merchant_id(merchant.id)
      price_sum = merchant_items.map do |item|
        item.unit_price
      end.reduce(:+)
      price_sum / BigDecimal.new(merchant_items.length)
    end
    merchant_average_sum = merchant_averages.inject(BigDecimal.new(0)) do |sum, number|
      sum + number
    end
    merchant_average_sum / BigDecimal.new(merchant_averages.length)
  end

  def golden_items
    @items.all.find_all do |item|
      item.unit_price >= (@items.item_price_standard_deviation * 2) + @items.average_item_price
    end
  end






end
