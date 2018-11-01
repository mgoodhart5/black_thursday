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
    @status = invoice_info[:status].to_sym
    @created_at = time_change(invoice_info[:created_at])
    @updated_at = time_change(invoice_info[:updated_at])
  end

  def time_change(time)
    if time.class == String
      Time.parse(time)
    else
      time
    end
  end

end
