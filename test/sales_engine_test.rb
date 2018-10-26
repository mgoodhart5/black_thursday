require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesEngineTest < MiniTest::Test
  def test_that_it_exists
    se = SalesEngine.from_csv({
      :items     => "./test/item_sample.csv",
      :merchants => "./test/merchant_sample.csv",
    })
    assert_instance_of SalesEngine, se
  end

  def test_it_can_return_an_instance_of_item_repo_with_items
    se = SalesEngine.from_csv({
      :items     => "./test/item_sample.csv",
      :merchants => "./test/merchant_sample.csv",
    })

    assert_instance_of ItemRepo, se.items
  end
end


# def create_items(item_data)
#   things = CSV.read(item_data, headers: true, header_converters: :symbol)
#   @all = things.map do |thing|
#     Item.new(thing)
#   end
# end
