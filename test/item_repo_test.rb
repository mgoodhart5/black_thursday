require_relative 'test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./test/item_sample.csv",
      :merchants => "./test/merchant_sample.csv",
      :invoices => "./test/invoice_sample.csv"
    })
    @ir = @sales_engine.items
  end

  def test_it_exists

    assert_instance_of ItemRepo, @ir
  end

  def test_it_starts_with_an_empty_array

    assert_instance_of Array, @ir.all
  end

  def test_that_it_can_create_item_instances

    assert_equal 6, @ir.all.count
  end

  def test_it_can_be_found_with_id
    id = 2

    assert_instance_of Item, @ir.find_by_id(id)
  end

  def test_it_can_be_found_by_name
    name = "name_1"

    assert_instance_of Item, @ir.find_by_name(name)
  end

  def test_it_can_find_all_with_description_or_returns_empty_array
    description_1 = "description_1"
    description_2 = "dan loves coffee"

    assert_instance_of Array, @ir.find_all_with_description(description_1)
    assert_equal [], @ir.find_all_with_description(description_2)
  end

  def test_it_can_find_all_by_price_or_returns_empty_array
    item = @ir.find_all_by_price(20)

    assert_equal 2, item.count
  end

  def test_it_can_find_all_in_price_range
    items = @ir.find_all_by_price_in_range(20..40)

    assert_equal 4, items.count
  end

  def test_it_can_find_all_by_merchant_id
    merchant_id = 12334112
    merchants = @ir.find_all_by_merchant_id(merchant_id)
    expected = 3

    assert_equal expected, merchants.count
  end

  def test_it_can_find_current_highest_id

    assert_equal 6, @ir.find_highest_id
  end

  def test_it_can_create_an_item_from_provided_attributes_with_highest_id_plus_1
    new_item = ({:name => "princess_glitter"})
    item = @ir.create(new_item)

    assert_equal 7, item.id
  end

  def test_it_can_update_attributes_by_id
    attributes = ({:name => "princess_glitter", :description => "beautiful", :unit_price => "1000"})
    item = @ir.update(3, attributes)

    assert_equal "beautiful", item.description
    assert_equal "princess_glitter", item.name
    assert_equal "1000", item.unit_price
  end

  def test_it_can_delete_item_from_id
    @ir.all.count

    assert_equal 6, @ir.all.count

    id = 2
    @ir.delete(id)
    assert_equal 5, @ir.all.count
  end

  def test_that_it_can_calculate_average_price_for_all_items

    assert_equal 28, @ir.average_item_price.to_i
  end

  def test_that_it_can_calculate_standard_devation_of_item_price

    assert_equal 14.72, @ir.item_price_standard_deviation
  end

end
