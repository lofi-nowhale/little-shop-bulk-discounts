class BulkDiscountsController < ApplicationController
  def index
    # require 'pry';binding.pry
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
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.new(name: params[:name], percentage: params[:percentage], threshold: params[:threshold])
    if params[:name].present? && params[:percentage].present? && params[:threshold].present?
      merchant.bulk_discounts.create(name: params[:name], percentage: params[:percentage], threshold: params[:threshold])
      redirect_to merchant_bulk_discounts_path
      flash[:alert] = "Bulk Discount Has Been Created!"
    else 
      flash[:error] = "WARNING: DISCOUNT HAS NOT BEEN CREATED! PLEASE FILL OUT ALL FIELDS AND RE-SUBMIT!"
      redirect_to "/merchants/#{merchant.id}/bulk_discounts/new"
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end
end