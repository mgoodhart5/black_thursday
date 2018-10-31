require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repo'
require 'mathn'
require 'date'
require 'CSV'

class SalesAnalyst
 attr_reader :merchant_count_array, :mean, :next, :average_items_per_merchant
  def initialize(items, merchants, invoices)
    @invoices = invoices
    @items = items
    @merchants = merchants
    @merchant_items_count_array = counted_items
    @item_mean = mean_of_merchant_items
    @average_price_per_merchant = average_average_price_per_merchant
    @next_items = next_step_items
    @average_items_per_merchant = average_items_per_merchant
    @average_items_per_merchant_standard_deviation = average_items_per_merchant_standard_deviation
    @average_invoices_per_merchant = average_invoices_per_merchant
    @merchant_invoices_count_array = counted_invoices
    @invoice_mean = mean_of_merchant_invoices
    @next_invoices = next_step_invoices
    @invoice_standard_dev = average_invoices_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(@next_items).round(2)
  end

  def counted_items#(count)
    @merchants.all.map do |merchant|
       @items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def mean_of_merchant_items
    sum = 0
    @merchant_items_count_array.each do |number|
      sum += number
    end
    sum / @merchants.all.count
  end

  def next_step_items
    # also rename this method
    sum_2 = 0
    @merchant_items_count_array.map do |number|
      answer = (number - @item_mean)
      answer * answer
    end.each do |number|
      sum_2 += number
    end
    sum_2 / ((@merchant_items_count_array.count.to_f) - 1)
  end

  def merchants_with_high_item_count
      @merchants.all.find_all do |merchant|
      merchant_items = @items.find_all_by_merchant_id(merchant.id)
      merchant_items.length >= (@average_items_per_merchant + @average_items_per_merchant_standard_deviation)
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
      Math.sqrt(@next_invoices).round(2)
  end

  def counted_invoices#(count)
    @merchants.all.map do |merchant|
       @invoices.find_all_by_merchant_id(merchant.id).count
    end
  end

  def mean_of_merchant_invoices
    sum = 0
    @merchant_invoices_count_array.each do |number|
      sum += number
    end
    sum.to_f / @merchants.all.count
  end

  def next_step_invoices
    # also rename this method
    sum_2 = 0
    @merchant_invoices_count_array.map do |number|
      answer = (number - @invoice_mean)
      answer * answer
    end.each do |number|
      sum_2 += number
    end
    sum_2 / ((@merchant_invoices_count_array.count.to_f) - 1)
  end

  def top_merchants_by_invoice_count
    @merchants.all.find_all do |merchant|
      merchant_invoices = @invoices.find_all_by_merchant_id(merchant.id)
      (merchant_invoices.count) < ((@invoice_standard_dev * 2) + @invoice_mean)
    end
  end

  def bottom_merchants_by_invoice_count
    @merchants.all.find_all do |merchant|
      merchant_invoices = @invoices.find_all_by_merchant_id(merchant.id)
      (merchant_invoices.count) < ((@invoice_standard_dev * 2) + @invoice_mean)
    end
  end

  def numbered_days
    days = @invoices.all.map do |invoice|
      invoice.created_at
    end
    days_array = days.map do |day|
      Date.parse(day).cwday
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
    # also rename this method
    sum_2 = 0
    numbered_days.map do |day|
      answer = (day - mean_of_days_occurences)
      answer * answer
    end.each do |number|
      sum_2 += number
    end
    answer = sum_2 / ((numbered_days.count.to_f) - 1)
    deviation = Math.sqrt(answer).round(2)
    deviation
  end

  def top_days_by_invoice_count
    top_days = days_occurence.select do |key, value|
      value >= (days_standard_dev + mean_of_days_occurences)
    end
    top_days.map do |key, value|
      days[key]
    end
  end



end
