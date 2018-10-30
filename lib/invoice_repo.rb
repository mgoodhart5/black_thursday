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

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_highest_id
    current_highest = @all.max_by do |invoice|
      invoice.id
    end
    current_highest.id.to_i
  end

  def create(attributes)
   new_id = find_highest_id + 1
   attributes[:id] = new_id
   @all << new_invoice = Invoice.new(attributes)
   new_invoice # is this supposed to have the newest times ie. created_at
  end

  def update(id, attributes)
  single_invoice = find_by_id(id)
   if single_invoice
     single_invoice.status = attributes[:status] if attributes[:status]
     single_invoice.updated_at = Time.now
   end
   single_invoice
  end

  def delete(id)
    @all.delete_if do |invoice|
      invoice.id == id
    end
  end

end
