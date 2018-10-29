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
      :invoices => "./test/invoice_sample.csv"
    })
    @sa = se.analyst
  end

  def test_that_it_exists


    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant


    assert_equal 2.0, @sa.average_items_per_merchant
  end


  def test_that_an_array_of_counted_item_numbers_is_returned

    @sa.counted_items
    assert_equal [1, 3, 2], @sa.merchant_count_array
  end


  def test_that_it_can_count_items_for_each_merchant_and_add_then_return_mean

   @sa.mean_of_merchant_items
    assert_equal 2, @sa.mean
  end

  def test_the_next_step_of_standard_deviation

    @sa.next_step
    assert_equal 1.0, @sa.next
  end

  def test_that_it_can_calculate_average_items_per_merchant_standard_deviation


    assert_equal 1.0, @sa.average_items_per_merchant_standard_deviation
  end

  def test_for_merchants_with_high_item_count


    assert_equal 1, @sa.merchants_with_high_item_count.length
    assert_equal 12334112, @sa.merchants_with_high_item_count.first.id
  end

  def test_that_it_can_calculate_average_price_per_merchant


   assert_equal BigDecimal.new(30), @sa.average_item_price_for_merchant(12334112)
  end

  def test_that_it_returns_average_average_price_per_merchant


    assert_equal BigDecimal.new(25), @sa.average_average_price_per_merchant
  end

  def test_that_it_can_find_all_golden_items

    assert_equal [], @sa.golden_items
  end

  def test_can_calculate_average_invoices_per_merchant

    assert_equal 2.33, @sa.average_invoices_per_merchant
  end

  # def test_it_can_calculate_average_invoices_per_merchant_standard_deviation
  #
  #   @sa.counted_items(@items)
  #   assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  # end
end
