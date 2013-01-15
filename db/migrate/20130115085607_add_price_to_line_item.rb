class AddPriceToLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal

     say_with_time "Updating prices..." do
       LineItem.find(:all).each do |lineitem|
         lineitem.price = lineitem.product.price
         lineitem.save
       end
     end
  end

  def self.down
    remove_column :line_items, :price
  end
end
