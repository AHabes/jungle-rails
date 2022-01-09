class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    render :show # also implicit. Instance variables are transferred between the controller and the view
  end

end
