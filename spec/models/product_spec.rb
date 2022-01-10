require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save successfully when all four validations are met' do
      @category = Category.create(name: 'Accessories')
      @product = Product.create(name: 'Sunglasses', category: @category, quantity: 1, price: 1500)
      @product.save!
      expect(@product).to be_valid
    end
    it 'should throw an error if product is created with name = nil' do
      @category = Category.create(name: 'Accessories')
      @product = Product.create(name: nil, category: @category, quantity: 1, price: 1500)
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end
    it 'should throw an error if product is created with category = nil' do
      @product = Product.create(name: 'Sunglasses', category: nil, quantity: 1, price: 1500)
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
    it 'should throw an error if product is created with quantity = nil' do
      @category = Category.create(name: 'Accessories')
      @product = Product.create(name: 'Sunglasses', category: @category, quantity: nil, price: 1500)
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end
    it 'should throw an error if product is created with price = nil' do
      @category = Category.create(name: 'Accessories')
      @product = Product.create(name: 'Sunglasses', category: @category, quantity: 1)
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end
  end
end
