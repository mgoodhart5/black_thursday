require_relative 'test_helper'
require_relative '../lib/merchant_repo'


class MerchantRepoTest < MiniTest::Test
  def test_it_exists
    mr = MerchantRepo.new('./test/merchant_sample.csv')

    assert_instance_of MerchantRepo, mr
  end

  def test_it_starts_with_an_empty_array
    mr = MerchantRepo.new('./test/merchant_sample.csv')

    assert_instance_of Array, mr.merchants
  end

  def test_that_it_can_create_merchant_instances
    mr = MerchantRepo.new('./test/merchant_sample.csv')

    assert_equal 3, mr.merchants.count
  end

  def test_it_can_be_found_wiht_id
    mr = MerchantRepo.new('./test/merchant_sample.csv')
    id = "12334112"

    assert_instance_of Merchant, mr.find_by_id(id)
  end

  def test_it_can_be_found_by_name
    mr = MerchantRepo.new('./test/merchant_sample.csv')
    name = "Candisart"

    assert_instance_of Merchant, mr.find_by_name(name)
  end

  def test_it_can_find_all_by_name
    mr = MerchantRepo.new('./test/merchant_sample.csv')
    name = "Candisart"

    assert_instance_of Array, mr.find_all_by_name(name)
  end

  def test_it_can_fin_highest_id
    mr = MerchantRepo.new('./test/merchant_sample.csv')

    assert_equal '12334113', mr.find_highest_id
  end

  def test_it_can_create_a_mercahnt_with_attributes
    skip
    mr = MerchantRepo.new('./test/merchant_sample.csv')
    new_merchant = ({:name => "princess"})
    merchant = mr.create(new_merchant)
    assert_equal 12334113, merchant.id
  end





end
