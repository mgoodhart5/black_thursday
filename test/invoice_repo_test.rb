require_relative 'test_helper'
require_relative '../lib/invoice_repo'

class InvoiceRepoTest < MiniTest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./test/item_sample.csv",
      :merchants => "./test/merchant_sample.csv",
      :invoices => "./test/invoice_sample.csv"
    })
    @invoices = @sales_engine.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, @invoices
  end

  def test_all_returns_an_array_of_all_invoices
    assert_instance_of Array, @invoices.all
  end

  def test_find_by_id_returns_an_instance_of_invoice_or_nil
    assert_equal nil, @invoices.find_by_id(1)
      assert_instance_of Invoice, @invoices.find_by_id(9)
  end

  def test_it_can_find_all_by_customer_id
    found = @invoices.find_all_by_customer_id(2)
    assert_equal 4, found.count
  end

  def test_it_can_find_all_by_merchant_id
    found = @invoices.find_all_by_merchant_id(12334113)
    assert_equal 2, found.count
  end

  def test_it_can_find_all_by_status
    found = @invoices.find_all_by_status("pending")
    assert_equal 3, found.count
  end

  def test_it_can_create_new_invoice
    attributes = ({:status => "shipped"})
    new_invoice = @invoices.create(attributes)
    assert_instance_of Invoice, new_invoice
  end

  def test_it_can_update_an_items_status
    attributes = ({:status => "shipped"})
    invoice = @invoices.update(11, attributes)

    assert_equal "shipped", invoice.status
    assert_instance_of Time, invoice.updated_at
  end

  def test_it_can_delete_invoice_by_id
    assert_equal 7, @invoices.all.count

    id = 9
    @invoices.delete(id)
    assert_equal 6, @invoices.all.count
  end

end
