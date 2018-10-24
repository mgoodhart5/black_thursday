require_relative 'test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < MiniTest::Test
  def test_it_exists
    ir = ItemRepo.new
    assert_instance_of ItemRepo, ir
  end

  def test_it_starts_with_an_empty_array
    ir = ItemRepo.new
    assert_equal [], ir.all
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
