class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchare order"]
  has_many :line_items, :dependent => :destroy

  validates :pay_type, :inclusion => PAYMENT_TYPES
  validates :name, :address, :email, :presence => true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil # da se ne bi obrisao prilikom brisanja cart_id
      line_items << line_item
    end
  end
end

