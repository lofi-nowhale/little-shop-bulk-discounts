class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new 
    # require 'pry';binding.pry
    # @bulk_discount = BulkDiscount.new
  end

  def create
    require 'pry';binding.pry
  end
end