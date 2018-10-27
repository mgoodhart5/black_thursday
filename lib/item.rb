require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :merchant_id,
              :created_at

  attr_accessor :name,
                :description,
                :updated_at,
                :unit_price


  def initialize(item_information)
    @id = item_information[:id].to_i
    @name = item_information[:name]
    @description = item_information[:description]
    @unit_price = big_decimal_converter(item_information[:unit_price])
    @created_at = time_change(item_information[:created_at])
    @updated_at = time_change(item_information[:updated_at])
    @merchant_id = item_information[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def big_decimal_converter(price)
    significant_digits = price.to_s.length
    num = price.to_f / 100
    BigDecimal.new(num, significant_digits)
  end

  def time_change(time)
    if time.class == String
      Time.parse(time)
    else
      time
    end
  end

end
