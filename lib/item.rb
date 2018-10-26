require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at


  def initialize(item_information)
    @id = item_information[:id].to_i
    @name = item_information[:name]
    @description = item_information[:description]
    @unit_price = BigDecimal.new(item_information[:unit_price], (item_information[:unit_price].length)) / 100
    @created_at = time_change(item_information[:created_at])
    @updated_at = time_change(item_information[:updated_at])
    @merchant_id = item_information[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
    # binding.pry
    # what the fuck/this requires more research
  end

  def time_change(time)
    if time.class == String
      Time.parse(time)
    else
      time
    end
  end

end
