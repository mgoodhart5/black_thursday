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

  #
  def test_it_exists
    assert_instance_of InvoiceRepo, @invoices
  end

  def test_all_returns_an_array_of_all_invoices
    assert_instance_of Array, @invoices.all
  end

end
