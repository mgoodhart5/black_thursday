require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/sales_analyst'
require_relative '../lib/item'
require_relative '../lib/merchant'

class SalesEngine
  attr_reader :analyst, :merchants_repo, :items_repo
  attr_accessor :items, :merchants

  def initialize(csv_files)
    @merchants = CSV.open(csv_files[:merchants], headers: true, header_converters: :symbol)
    @merchants_repo = MerchantRepo.new(create_merchants(@merchants))
    @items = CSV.open(csv_files[:items], headers: true, header_converters: :symbol)
    @items_repo = ItemRepo.new(create_items(@items))
    @analyst = SalesAnalyst.new(@item_repo, @merchant_repo)
  end


  def self.from_csv(csv_files)
    self.new(csv_files)
  end

  def create_merchants(people)
    @all = people.map do |person|
      Merchant.new(person)
    end
  end

  def create_items(item_data)
    @all = item_data.map do |item|
      Item.new(item)
    end
  end

end
