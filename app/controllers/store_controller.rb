class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      @cart = current_cart
      @products = Product.all
    end
    if session[:counter].nil?
      @counter=1
    else
      @counter = session[:counter] + 1
    end
    session[:counter] = @counter
  end
end
