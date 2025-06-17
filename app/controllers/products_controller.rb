class ProductsController < ApplicationController
  PER_PAGE = 20

  def index
    @page = params[:page].to_i
    @page = 1 if @page < 1

    products = Product.with_rating_data
                      .search(params[:query])
                      .filter_by_rating(params[:rating])
                      .order(average_rating: :desc)

    @total_pages = (products.count / PER_PAGE.to_f).ceil
    @products = products.offset((@page - 1) * PER_PAGE).limit(PER_PAGE)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "products",
          partial: "products",
          locals: { products: @products, page: @page, total_pages: @total_pages }
        )
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    @feedbacks = @product.feedbacks.includes(:user).order(created_at: :desc)
  end
end
