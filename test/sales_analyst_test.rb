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


  def test_that_an_array_of_counted_item_numbers_is_returned

    assert_equal [1, 3, 2], @sa.counted_items
  end


  def test_that_it_can_count_items_for_each_merchant_and_add_then_return_mean

    assert_equal 2, @sa.mean_of_merchant_items
  end

  def test_the_next_step_of_standard_deviation

    assert_equal 0.6666666666666666, @sa.next_step
  end

  def test_that_it_can_calculate_average_items_per_merchant_standard_deviation

    assert_equal 0.82, @sa.average_items_per_merchant_standard_deviation
  end


end
