require 'CSV'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceRepo
  attr_reader :all
  def initialize(invoice_data)
    @all = invoice_data
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

end
