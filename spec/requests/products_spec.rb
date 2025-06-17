require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    let!(:users) do
      Array.new(3) do
        User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.unique.email
        )
      end
    end

    let!(:products) do
      Array.new(5) do
        Product.create!(
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.paragraph(sentence_count: 2)
        )
      end
    end

    let!(:feedbacks) do
      Array.new(10) do
        Feedback.create!(
          rating: rand(1..5),
          comment: [ Faker::Quote.famous_last_words, nil ].sample,
          product: products.sample,
          user: users.sample
        )
      end
    end

    it "products should be present" do
      get products_path
      expect(response).to have_http_status(:ok)
      expect(assigns(:products)).to be_present
    end

    it "pagination shows fist page as default" do
      get products_path, params: { page: -5 }
      expect(assigns(:page)).to eq(1)
    end

    it "filters products by query" do
      target = products.first
      target.update(name: "searchedProduct")

      get products_path, params: { query: "searchedProduct" }
      expect(assigns(:products)).to include(target)
    end
  end
end
