require 'CSV'
require_relative '../lib/merchant'

class MerchantRepo
   attr_reader :all

  def initialize(merchant_data)
    @all = []
    create_merchants(merchant_data)
  end

  def create_merchants(merchant_data)
    people = CSV.read(merchant_data, headers: true, header_converters: :symbol)
    @all = people.map do |person|
      Merchant.new(person)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    current_highest = @all.max_by do |merchant|
      merchant.id
    end
    current_highest.id.to_i
  end

  def create(attributes)
   new_id = find_highest_id + 1
   attributes[:id] = new_id
   @all << new_merchant = Merchant.new(attributes)
   new_merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    if merchant.nil?
      merchant
    else
      merchant.name = attributes[:name]
    end
    #why is this letting the id be updated? is that what the spec harness says?
  end

  def delete(id)
    @all.delete_if do |merchant|
      merchant.id == id
    end
  end

end
