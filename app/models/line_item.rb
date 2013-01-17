class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  before_save :get_the_price_from_the_product
  
  def get_the_price_from_the_product
    self.price ||= self.product.price
  end

  def total_price
    price * quantity
  end

  def decrement_quantity
    if self.quantity > 1
      self.quantity -= 1
    else
      destroy
    end
  end
end
