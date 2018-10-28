require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/sales_analyst'
require_relative '../lib/item'
require_relative '../lib/merchant'
require 'CSV'

class SalesEngine
  attr_reader :analyst, :items, :merchants
  attr_accessor :item_data, :merchant_data

  def initialize(csv_files)
    @merchant_data = CSV.open(csv_files[:merchants], headers: true, header_converters: :symbol)
    @merchants = MerchantRepo.new(create_merchants(@merchant_data))
    @item_data = CSV.open(csv_files[:items], headers: true, header_converters: :symbol)
    @items = ItemRepo.new(create_items(@item_data))
    @analyst = SalesAnalyst.new(@items, @merchants)
  end


  def self.from_csv(csv_files)
    self.new(csv_files)
  end

  def create_merchants(people)
    all_merchants = []
     people.each do |person|
      all_merchants <<  Merchant.new(person)
    end
    all_merchants
  end

  def create_items(item_data)
    all_items = []
     item_data.each do |item|
      all_items << Item.new(item)
    end
    all_items
  end

end
