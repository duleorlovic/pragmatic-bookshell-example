class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def total_price
    price * quantity
  end

  def decrement_quantity
    if self.quantity > 1
      self.quantity -= 1
    else
      self.destroy
    end
  end
end
