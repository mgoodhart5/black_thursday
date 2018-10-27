require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/merchant'
require 'mathn'

class SalesAnalyst

  def initialize(item_repo, merchant_repo)
    @item_repo = item_repo
    @merchant_repo = merchant_repo
  end

  def average_items_per_merchant
    (@item_repo.all.count.to_f / @merchant_repo.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(next_step).round(2)
  end

  def counted_items
    count = []
    @merchant_repo.all.each do |merchant|
      count << @item_repo.find_all_by_merchant_id(merchant.id).count
    end
    count
  end

  def mean_of_merchant_items
    sum = 0
    counted_items.each do |number|
      sum += number
    end
    sum / @merchant_repo.all.count
  end

  def next_step
    sum_2 = 0
    counted_items.map do |number|
      answer = (number - mean_of_merchant_items)
      answer * answer
    end.each do |number|
      sum_2 += number
    end
    final = sum_2 / ((counted_items.count.to_f) -1)
    final
  end


end
