require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  
  test "the truth" do
    assert true
  end
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = Product.new(:title => "My Book Title",
                    :description => "yyy",
                    :image_url => "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
        product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
        product.errors[:price].join('; ')

    product.price = 1
    assert product.valid?
  end
  
  test "image url" do
    ok = %w{ fred.gif house.jpg 1.png }
    bad = %w{ fred 1.pdf one.doc }
    
    ok.each do |name|
      #assert new_product(name).validate?, "#{name} shouldn't be invalid"
    end
    bad.each do |name|
      #assert new_product(name).validate?, "#{name} shouldn't be valid"
    end
  end
  
  test "product is not valid without a unique title" do
    product = Product.new( :title => products(:dukes_product).title,
                        :description => "des",
                        :price => 3.2,
                        :image_url => "i.jpg" )
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),    
              product.errors[:title].join('; ')
  end

  
end
