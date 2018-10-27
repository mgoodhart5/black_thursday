require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/item_sample.csv",
      :merchants => "./test/merchant_sample.csv",
    })
    @sa = se.analyst
  end

  def test_that_it_exists

    assert_instance_of SalesAnalyst, @sa
  end

  # def test_that_it_can_calculate_average_items_per_merchant
  #
  #   assert_equal 2, @sa.average_items_per_merchant
  # end

  def test_that_it_can_count_items_for_each_merchant_and_add_then_return_mean

    assert_equal 2, @sa.mean_of_merchant_items
  end

  # def test_that_it_can_calculate_average_items_per_merchant_standard_deviation
  #
  #   assert_equal 1.29, @sa.average_items_per_merchant_standard_deviation
  # end

end
