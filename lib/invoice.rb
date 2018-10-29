require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at


  attr_accessor :status, :updated_at

  def initialize(invoice_info)
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @merchant_id = invoice_info[:merchant_id].to_i
    @status = invoice_info[:status]
    @created_at = invoice_info[:created_at]
    @updated_at = invoice_info[:updated_at]
  end

end
