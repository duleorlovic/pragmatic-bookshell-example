class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy #brisanjem carta, pronaci i obrisati sve line_items sa odgovarajucim cart_id

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def add_product(product)
    current_item = line_items.find_by_product_id(product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(:product_id => product.id)
    end
    current_item
  end
end
