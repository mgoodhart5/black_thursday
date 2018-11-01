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


    assert_equal [1, 3, 2], @sa.counted_items
  end


  def test_that_it_can_count_items_for_each_merchant_and_add_then_return_mean


    assert_equal 2, @sa.mean_of_merchant_items
  end

  def test_the_next_step_of_standard_deviation


    assert_equal 1.0, @sa.items_squared
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

  def test_it_can_calculate_average_invoices_per_merchant_standard_deviation

    assert_equal 0.58, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_top_merchants_by_invoice_count

    assert_instance_of Array, @sa.top_merchants_by_invoice_count
  end

  def test_it_can_find_low_merchants_by_invoice_count

    assert_instance_of Array, @sa.bottom_merchants_by_invoice_count
  end

  def test_that_numerical_dates_can_be_turned_into_corresponding_numbers

    assert_equal [5, 5, 0, 1, 2, 6, 1], @sa.numbered_days
  end

  def test_we_can_count_occurence_of_days

    assert_equal ({5=>2, 0=>1, 1=>2, 2=>1, 6=>1}), @sa.days_occurence
  end

  def test_that_we_have_a_mean_of_days_occurence

    assert_equal 1, @sa.mean_of_days_occurences
  end

  def test_that_we_have_a_hash_of_days

    assert_equal "Monday", @sa.days[1]
  end

  def test_that_we_can_find_standard_deviation_for_days

    assert_equal 0.71, @sa.days_standard_dev
  end

  def test_that_we_can_find_top_days_by_invoice_count

    assert_equal (["Friday", "Monday"]), @sa.top_days_by_invoice_count
  end

  def test_it_can_check_percentage_of_invoice_status

    assert_equal 42.86, @sa.invoice_status(:pending)
    assert_equal 57.14, @sa.invoice_status(:shipped)
  end

end
