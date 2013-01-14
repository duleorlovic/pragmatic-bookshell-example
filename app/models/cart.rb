class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy #brisanjem carta, pronaci i obrisati sve line_items sa odgovarajucim cart_id
end
