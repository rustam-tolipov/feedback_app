class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy(
      Product.search(params[:query])
                      .filter_by_rating(params[:rating])
                      .order(average_rating: :desc))

    respond_to do |format|
      format.html do
        if turbo_frame_request?
          render partial: "products/product_grid", locals: { products: @products, pagy: @pagy }
        else
          render :index
        end
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    @pagy, @feedbacks = pagy(@product.feedbacks.includes(:user).order(created_at: :desc), limit: 5)
    @feedback = @product.feedbacks.build
  end
end
