require 'CSV'
require_relative '../lib/merchant'

class MerchantRepo
   attr_reader :merchants
  def initialize(merchant_data)
    @merchants = []
    create_merchants(merchant_data)

  end

  def create_merchants(merchant_data)
    people = CSV.read(merchant_data, headers: true, header_converters: :symbol)
    @merchants = people.map do |person|
      Merchant.new(person)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    current_highest = @merchants.max_by do |merchant|
      merchant.id
    end
    current_highest.id.to_i
  end

  def create(attributes)
   new_id = find_highest_id + 1
   attributes[:id] = new_id
   Merchant.new(attributes)
  end

end
