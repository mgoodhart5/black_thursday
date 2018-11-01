require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/sales_engine'
# require_relative '../lib/item'
# require_relative '../lib/merchant'
# require_relative '../lib/invoice'
require_relative '../lib/invoice_repo'
require 'mathn'
require 'CSV'

class SalesAnalyst

  def initialize(items, merchants, invoices)
    @invoices = invoices
    @items = items
    @merchants = merchants
    @item_mean = mean_of_merchant_items
    @items_squared = items_squared
    @invoice_mean = mean_of_merchant_invoices
    @invoices_squared = invoices_squared
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(@items_squared).round(2)
  end

  def counted_items
    items_count = @merchants.all.map do |merchant|
       @items.find_all_by_merchant_id(merchant.id).count
    end
    items_count
  end

  def mean_of_merchant_items
    sum = 0
    counted_items.each do |number|
      sum += number
    end
    sum / @merchants.all.count
  end

  def items_squared
    sum_2 = 0
    counted_items.map do |number|
      answer = (number - @item_mean)
      answer * answer
    end.each do |number|
      sum_2 += number
    end
    sum_2 / ((counted_items.count.to_f) - 1)
  end

  def merchants_with_high_item_count
      @merchants.all.find_all do |merchant|
      merchant_items = @items.find_all_by_merchant_id(merchant.id)
      merchant_items.length >= (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_for_merchant(id)
    merchant_items = @items.find_all_by_merchant_id(id)
    accumulator = BigDecimal.new(0)
    merchant_items.each do |item|
      accumulator += item.unit_price
    end
    number = (accumulator / BigDecimal.new(merchant_items.length))
    answer = BigDecimal.new(number, 4)
    answer.round(2)
  end

  def average_average_price_per_merchant
    merchant_averages = @merchants.all.map do |merchant|
      merchant_items = @items.find_all_by_merchant_id(merchant.id)
      price_sum = merchant_items.map do |item|
        item.unit_price
      end.reduce(:+)
      price_sum / BigDecimal.new(merchant_items.length)
    end
    merchant_average_sum = merchant_averages.inject(BigDecimal.new(0)) do |sum, number|
      sum + number
    end
    answer = merchant_average_sum / BigDecimal.new(merchant_averages.length)
    answer.round(2)
  end

  def golden_items
    @items.all.find_all do |item|
      item.unit_price >= (@items.item_price_standard_deviation * 2) + @items.average_item_price
    end
  end

  def average_invoices_per_merchant
    (@invoices.all.count.to_f / @merchants.all.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
      Math.sqrt(@invoices_squared).round(2)
  end

  def counted_invoices
    invoice_count = @merchants.all.map do |merchant|
       @invoices.find_all_by_merchant_id(merchant.id).count
    end
    invoice_count
  end

  def mean_of_merchant_invoices
    sum = 0
    counted_invoices.each do |number|
      sum += number
    end
    sum.to_f / @merchants.all.count
  end

  def invoices_squared
    sum_2 = 0
    counted_invoices.map do |number|
      answer = (number - @invoice_mean)
      answer * answer
    end.each do |number|
      sum_2 += number
    end
    sum_2 / ((counted_invoices.count.to_f) - 1)
  end

  def top_merchants_by_invoice_count
    @merchants.all.find_all do |merchant|
      merchant_invoices = @invoices.find_all_by_merchant_id(merchant.id)
      merchant_invoices.count > (average_invoices_per_merchant_standard_deviation * 2) + @invoice_mean
    end
  end

  def bottom_merchants_by_invoice_count
    @merchants.all.find_all do |merchant|
      merchant_invoices = @invoices.find_all_by_merchant_id(merchant.id)
      merchant_invoices.count < @invoice_mean - (average_invoices_per_merchant_standard_deviation * 2)
    end
  end

  def numbered_days
    days = @invoices.all.map do |invoice|
      invoice.created_at
    end
    days_array = days.map do |day|
      day.wday
    end
     days_array
  end

  def days_occurence
    counts = Hash.new(0)
    numbered_days.each do |day|
      counts[day] += 1
    end
    counts
  end

  def mean_of_days_occurences
    sum = 0
    days_occurence.each do |date, occurence|
      sum += occurence
    end
    answer = (sum.to_f / 7).round(2)
    answer
  end

  def days
    { 1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday",
      7 => "Sunday" }
  end

  def days_standard_dev
    sum_2 = 0
    days_occurence.map do |day, times|
      answer = (times - mean_of_days_occurences)
      answer * answer
    end.each do |number|
      sum_2 += number
    end
    answer = sum_2 / (days_occurence.keys.count - 1)
    deviation = Math.sqrt(answer).round(2)
    deviation
  end

  def top_days_by_invoice_count
    top_days = days_occurence.find_all do |key, value|
      value >= (days_standard_dev + mean_of_days_occurences)
    end
    top_days.map do |key, value|
      days[key]
    end
  end

  def invoice_status(status)
    found = @invoices.all.find_all do |invoice|
      invoice.status == status
    end
    percentage = (found.count.to_f / @invoices.all.count) * 100
    percentage.round(2)
  end

end
