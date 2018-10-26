require 'CSV'


class SalesEngine
  attr_accessor :items, :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants

  end


  def self.from_csv(csv_files)
    items = ItemRepo.new(csv_files[:items])
    merchants = MerchantRepo.new(csv_files[:merchants])

    self.new(items, merchants)
  end
end
