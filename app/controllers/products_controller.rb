class ProductsController < ApplicationController
  def index
    @products = Product.with_rating_data
                      .search(params[:query])
                      .filter_by_rating(params[:rating])
                      .order(average_rating: :desc)
                      .limit(20)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render partial: "products", locals: { products: @products }
      end
    end
  end
end