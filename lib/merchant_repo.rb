require_relative '../lib/merchant'
require_relative '../lib/sales_engine'
require_relative '../lib/method_module'

class MerchantRepo
  include FindMethods

   attr_reader :all

  def initialize(merchant_data)
    @all = merchant_data
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  # def find_highest_id
  #   current_highest = @all.max_by do |merchant|
  #     merchant.id
  #   end
  #   current_highest.id.to_i
  # end

  def create(attributes)
   new_id = find_highest_id + 1
   attributes[:id] = new_id
   @all << new_merchant = Merchant.new(attributes)
   new_merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    if merchant
       merchant.name = attributes[:name] if attributes[:name]
    end
    merchant
  end

end
