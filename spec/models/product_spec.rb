require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
      it "saves successfully" do
        @category = Category.new(name: "Electronics")
        @category.save!
        @product = Product.new(name: "Product 1", description: "Desc 1", category_id: @category.id, quantity: 1, price: 100)
        @product.save!

        expect(@product.id).to be_present
      end

      it "validates name" do
        @category = Category.new(name: "Electronics")
        @category.save!
        @product = Product.new(name: nil, description: "Desc 1", category_id: @category.id, quantity: 1, price: 100)
        @product.save
        expect(@product.errors.full_messages.to_sentence).to include("Name can't be blank")
        expect(@product).to_not be_valid
      end

      it "validates price" do
        @category = Category.new(name: "Electronics")
        @category.save!
        @product = Product.new(name: "Product 1", description: "Desc 1", category_id: @category.id, quantity: 1, price: nil)
        @product.save
        expect(@product.errors.full_messages.to_sentence).to include("Price can't be blank")
        expect(@product).to_not be_valid
      end

      it "validates quantity" do
        @category = Category.new(name: "Electronics")
        @category.save!
        @product = Product.new(name: "Product 1", description: "Desc 1", category_id: @category.id, quantity: nil, price: 100)
        @product.save
        puts @product.errors.full_messages.to_sentence
        expect(@product.errors.full_messages.to_sentence).to include("Quantity can't be blank")
        expect(@product).to_not be_valid
      end

      it "validates category" do
        @product = Product.new(name: "Product 1", description: "Desc 1", category_id: nil, quantity: 1, price: 100)
        @product.save
        puts @product.errors.full_messages.to_sentence
        expect(@product.errors.full_messages.to_sentence).to include("Category can't be blank")
        expect(@product).to_not be_valid
      end
  end
end