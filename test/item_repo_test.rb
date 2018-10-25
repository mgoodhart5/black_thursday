require_relative 'test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < MiniTest::Test
  def test_it_exists
    ir = ItemRepo.new('./test/item_sample.csv')
    assert_instance_of ItemRepo, ir
  end

  def test_it_starts_with_an_empty_array
    ir = ItemRepo.new('./test/item_sample.csv')
    assert_instance_of Array, ir.all
  end

  def test_that_it_can_create_item_instances
    ir = ItemRepo.new('./test/item_sample.csv')

    assert_equal 3, ir.all.count
  end

  def test_it_can_be_found_with_id
    ir = ItemRepo.new('./test/item_sample.csv')
    id = 263395617

    assert_instance_of Item, ir.find_by_id(id)
    # confirmed this test, but there is a better way to run it
  end

  def test_it_can_be_found_by_name
    ir = ItemRepo.new('./test/item_sample.csv')
    name = "510+ RealPush Icon Set"

    assert_instance_of Item, ir.find_by_name(name)
    # confirmed this test
  end

  def test_it_can_find_all_with_description_or_returns_empty_array
    ir = ItemRepo.new('./test/item_sample.csv')
    description_1 = "glitter"
    description_2 = "dan loves coffee"

    assert_instance_of Array, ir.find_all_with_description(description_1)
    assert_equal [], ir.find_all_with_description(description_2)
    # confirmed
  end

  def test_it_can_find_all_by_price_or_returns_empty_array
    skip
    ir = ItemRepo.new('./test/item_sample.csv')
    price_1 = 10_000_000
    price_2 = 13.50
    #this is a test in progress...refactoring unit price method
    assert_equal [], ir.find_all_by_price(price_1)
    assert_instance_of Array, ir.find_all_by_price(price_2)
    binding.pry
  end

  def test_it_can_find_all_in_price_range
    skip
    skip
  end

  def test_it_can_find_all_by_merchant_id
    ir = ItemRepo.new('./test/item_sample.csv')
    merchant_id = "12334185"
    # merchant ids are strings!! this test is passing
    assert_instance_of Array, ir.find_all_by_merchant_id(merchant_id)
    binding.pry
  end

end



# The ItemRepository is responsible for holding and searching our Item instances. This object represents one line of data from the file items.csv.
#
# It offers the following methods:
#
# all - returns an array of all known Item instances
# find_by_id(id) - returns either nil or an instance of Item with a matching ID
# find_by_name(name) - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description(description) - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price(price) - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range(range) - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id(merchant_id) - returns either [] or instances of Item where the supplied merchant ID matches that supplied
# create(attributes) - create a new Item instance with the provided attributes. The new Item’s id should be the current highest Item id plus 1.
# update(id, attributes) - update the Item instance with the corresponding id with the provided attributes. Only the item’s name, desription, and unit_price attributes can be updated. This method will also change the items updated_at attribute to the current time.
# delete(id) - delete the Item instance with the corresponding id
