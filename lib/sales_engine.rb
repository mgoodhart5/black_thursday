require 'CSV'


class SalesEngine
  attr_reader :item_csv, :merchant_csv

  def initialize(csv_files)
    @csv_files =csv_files
    # @item_csv = csv_files[:items]
    # @merchant_csv = csv_files[:merchant]
  
  end


  def self.from_csv(csv_files)
    @item_csv = csv_files[:items]
    @merchant_csv = csv_files[:merchant]
    ItemRepo.new(@item_csv)
    MerchantRepo.new(@merchant_csv)
    self.from_csv(@merchant_repo, @item_csv)
  end
end
