require_relative 'test_helper'
require_relative '../lib/merchant_repo'


class MerchantRepoTest < MiniTest::Test

  def setup
    @file = './test/merchant_sample.csv'
  end

  def test_it_exists
    mr = MerchantRepo.new(@file)

    assert_instance_of MerchantRepo, mr
  end

  def test_it_starts_with_an_empty_array
    mr = MerchantRepo.new(@file)

    assert_instance_of Array, mr.all
  end

  def test_that_it_can_create_merchant_instances
    mr = MerchantRepo.new(@file)

    assert_equal 3, mr.all.count
  end

  def test_it_can_be_found_with_id_or_return_nil
    mr = MerchantRepo.new(@file)
    id_1 = 12334112

    assert_instance_of Merchant, mr.find_by_id(id_1)
    id_2 = 65

    assert_equal nil, mr.find_by_id(id_2)
    binding.pry
  end

  def test_it_can_be_found_by_name
    mr = MerchantRepo.new(@file)
    name = "Candisart"

    assert_instance_of Merchant, mr.find_by_name(name)
  end

  def test_it_can_find_all_by_name
    mr = MerchantRepo.new(@file)
    name = "Candisart"

    assert_instance_of Array, mr.find_all_by_name(name)
  end

  def test_it_can_find_highest_id
    mr = MerchantRepo.new(@file)

    assert_equal 12334113, mr.find_highest_id
  end

  def test_it_can_create_a_merchant_with_attributes
    mr = MerchantRepo.new(@file)
    new_merchant = ({:name => "princess"})
    merchant = mr.create(new_merchant)

    assert_equal 12334114, merchant.id
  end

  def test_it_can_update_attributes_by_id
    mr = MerchantRepo.new(@file)
    attributes = ({:name => "Glitter Store"})
    merchant = mr.update(12334112, attributes)
    # lets look at this tomorrow...to_i?

    assert_equal "Glitter Store", merchant.name
  end

  def test_it_can_be_deleted_by_id
    mr = MerchantRepo.new(@file)
    mr.create_merchants(@file)
    mr.merchants.count

    assert_equal 3, mr.all.count

    id = 12334112
    mr.delete(id)
    assert_equal 2, mr.all.count
  end

end
