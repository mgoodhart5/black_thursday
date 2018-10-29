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
end
