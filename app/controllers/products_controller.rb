class ProductsController < ApplicationController
  def index
    @products = Product
      .with_rating_data
      .order('average_rating DESC')
      .limit(20)
  end
end
