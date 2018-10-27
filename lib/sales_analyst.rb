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

  def mean_of_merchant_items
    count = []
    @merchant_repo.all.each do |merchant|
      count << @item_repo.find_all_by_merchant_id(merchant.id).count
    end
    sum = 0
    count.each do |number|
      sum += number
    end
    sum / @merchant_repo.all.count
  end

  # @item_repo.find_all_by_merchant_id(merchant.id) returns an array of
  # all the items assosciated with a merchant id

  # now all you need to do is to find how many items are in each of these
  # arrays and output a new array of these things

  # ex -> [ [item, item, item ], [item], [item, item]]
  # what u want -> [3, 1, 2]





  # def average_items_per_merchant_standard_deviation
  #
  # end



end
