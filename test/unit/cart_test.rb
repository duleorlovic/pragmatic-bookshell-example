require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @cart = Cart.create
    @book_one = products(:dukes_product)
    @book_two = products(:two)
  end
  test "adding two times the same book to the cart" do
    @cart.add_product(@book_one).save!
    @cart.add_product(@book_one).save!
    assert_equal 1, @cart.line_items.size
    assert_equal 2, @cart.line_items.first.quantity
    #assert_equal @book_one.price+@book_one.price,@cart.total_price
  end
  test "adding two unique books to cart" do
    @cart.add_product(@book_one).save!
    @cart.add_product(@book_two).save!
    assert_equal 2, @cart.line_items.size
    #assert_equal @book_one.price+@book_two.price,@cart.total_price

  end
end
