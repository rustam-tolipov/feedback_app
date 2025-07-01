class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy(
      Product.search(params[:query])
                      .filter_by_rating(params[:rating])
                      .order(average_rating: :desc))

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @product = Product.find(params[:id])
    @feedbacks = @product.feedbacks.includes(:user).order(created_at: :desc)
  end
end
