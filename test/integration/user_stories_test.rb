require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "buying a product" do
    #A user goes to the index page. They select a product, adding it to their
    #cart, and check out, filling in their details on the checkout form. When
    #they submit, an order is created containing their information, along with a
    #single line item corresponding to the product they added to their cart.
    #mail for confirmation and mail for ship date is send
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:dukes_product)
    payment_type = payment_types(:one)

    get "/"
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', :product_id => ruby_book.id
    assert_response :success
    
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    get "/orders/new"
    assert_response :success
    assert_template "new"
  
    post_via_redirect "/orders",
      :order => { :name => "Dave Thomas",
          :address => "123 The Street",
          :email => "dave@example.com",
          :payment_type_id => payment_type.id}
    assert_response :success
    assert_template "index"

    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size

    order = orders[0]

    assert_equal "Dave Thomas",order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal payment_type, order.payment_type
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'from@example.com', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end

  test "shiping a product" do
    user = users(:one)
    post_via_redirect "login", :name => user.name, :password => 'secret'
    order = orders(:one)
    ship_date_expected = Time.now.to_date
    order.ship_date = ship_date_expected
    put_via_redirect "orders/"+order.id.to_s, :order => order.attributes
    assert_response :success 
    order = orders(:one)
    Rails.logger.info order.attributes
    assert_equal ship_date_expected, order.ship_date 
    
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dule@example.org"], mail.to
    assert_equal 'from@example.com', mail[:from].value
    assert_equal "Pragmatic Store Order Shipped", mail.subject
  end


  test "sending error detected email" do
    # A user goes to the unknown cart
    # it should te redirected and
    # email error_detected send
    user = users(:one)
    post_via_redirect "login", :name => user.name, :password => 'secret'
    get_via_redirect "/carts/wobble"
    assert_template "index"

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["duleorlovic@gmail.com"], mail.to
    assert_equal 'from@example.com', mail[:from].value
    assert_equal "error detected", mail.subject
  end
 
end
