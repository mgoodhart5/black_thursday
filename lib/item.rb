class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item_information)
    @id = item_information[:id].to_i
    @name = item_information[:name]
    @description = item_information[:description]
    @unit_price = item_information[:unit_price]
    @created_at = item_information[:created_at]
    # time and big decimal
    @updated_at = item_information[:updated_at]
    @merchant_id = item_information[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
    # binding.pry
    # what the fuck
  end

end
