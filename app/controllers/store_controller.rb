class StoreController < ApplicationController
  def index
    @cart = current_cart
    @products = Product.all
    if session[:counter].nil?
      @counter=1
    else
      @counter = session[:counter] + 1
    end
    session[:counter] = @counter
  end
end
