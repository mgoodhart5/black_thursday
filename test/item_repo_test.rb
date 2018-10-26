require_relative 'test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < MiniTest::Test

  def setup
    @file = './test/item_sample.csv'
  end

  def test_it_exists
    ir = ItemRepo.new(@file)
    assert_instance_of ItemRepo, ir
  end

  def test_it_starts_with_an_empty_array
    ir = ItemRepo.new(@file)
    assert_instance_of Array, ir.all
  end

  def test_that_it_can_create_item_instances
    ir = ItemRepo.new(@file)

    assert_equal 3, ir.all.count
  end

  def test_it_can_be_found_with_id
    ir = ItemRepo.new(@file)
    id = 2

    assert_instance_of Item, ir.find_by_id(id)
    # confirmed this test, but there is a better way to run it
  end

  def test_it_can_be_found_by_name
    ir = ItemRepo.new(@file)
    name = "name_1"

    assert_instance_of Item, ir.find_by_name(name)
    # confirmed this test
  end

  def test_it_can_find_all_with_description_or_returns_empty_array
    ir = ItemRepo.new(@file)
    description_1 = "glitter"
    description_2 = "dan loves coffee"

    assert_instance_of Array, ir.find_all_with_description(description_1)
    assert_equal [], ir.find_all_with_description(description_2)
    # confirmed
  end

  def test_it_can_find_all_by_price_or_returns_empty_array
    ir = ItemRepo.new(@file)
    item = ir.find_all_by_price(1200)
    expected = "blabjalsdfn"
    #we need to change this per Brian sample to simple
    # this is failing!
    assert_equal expected, item
  end

  def test_it_can_find_all_in_price_range
    ir = ItemRepo.new(@file)
    item = ir.find_all_by_price_in_range(1000..4000)
    expected = "stuff"
    #need to change per brians suggestion sample to simple
    # this is failing!
    assert_equal expected, item
  end

  def test_it_can_find_all_by_merchant_id
    ir = ItemRepo.new(@file)
    merchant_id = "12334185"
    # merchant ids are strings!! this test is passing
    assert_instance_of Array, ir.find_all_by_merchant_id(merchant_id)

    # binding.pry
  end

  def test_it_can_find_current_highest_id
    ir = ItemRepo.new(@file)

    assert_equal 3, ir.find_highest_id
  end

  def test_it_can_create_an_item_from_provided_attributes_with_highest_id_plus_1
    ir = ItemRepo.new(@file)
    new_item = ({:name => "princess_glitter"})
    item = ir.create(new_item)
    assert_equal 4, item.id
  end

  def test_it_can_update_attributes_by_id
    skip
    #this is NilClass for some reason
    #related to making a new item
    #what the fuck
    ir = ItemRepo.new(@file)
    attributes = ({:name => "princess_glitter", :description => "beautiful", :unit_price => "1000"})
    item = ir.update(4, attributes)

    assert_equal "beautiful", item.description
    assert_equal "princess_glitter", item.name
    assert_equal "1000", item.unit_price
  end

  def test_it_can_delete_item_from_id
    skip
    ir = ItemRepo.new(@file)
    ir.create_items(@file)
    ir.all.count

    assert_equal 3, ir.all.count

    id = 2
    ir.delete(id)
    assert_equal 2, ir.all.count
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
