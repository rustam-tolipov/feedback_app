class FeedbacksController < ApplicationController
  require "csv"
  before_action :set_product, only: [ :new, :create ]

  def new
    @feedback = @product.feedbacks.build
  end

  def upload_csv
    if params[:file].present?
      filename = Rails.root.join("tmp", "uploads", "#{SecureRandom.hex(8)}.csv")
      FileUtils.mkdir_p(File.dirname(filename))
      File.write(filename, params[:file].read)

      ImportFeedbackCsvJob.perform_later(filename.to_s, params[:product_id])

      flash[:notice] = "CSV upload started. Feedbacks will be imported shortly."
    else
      flash[:alert] = "Please upload a CSV file."
    end

    redirect_to params[:product_id].present? ? product_path(params[:product_id]) : root_path
  end

  def create
    @feedback = @product.feedbacks.build(feedback_params)
    @feedback.user = User.first

    if @feedback.save
      respond_to do |format|
        format.html
        format.turbo_stream { flash.now[:notice] = "Feedback added." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:rating, :comment)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
