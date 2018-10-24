require 'csv'
class ItemRepo

  attr_reader :all

  def initialize
    @all = []
    item = CSV.open "./data/merchants.csv"
  end

end
