class FeedbacksController < ApplicationController
  require "csv"
  before_action :set_product, only: [ :new, :create ]

  def new
    @feedback = @product.feedbacks.build
  end

  def upload_csv
    result = Feedbacks::CsvImporter.call(params[:file], params[:product_id])

    if result[:failed].any?
      message = "#{result[:imported]} feedback(s) imported.<br>Some rows failed:<br>#{result[:failed].join('<br>')}"
      flash[:alert] = message.html_safe
    else
      flash[:notice] = "#{result[:imported]} feedback(s) imported."
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
