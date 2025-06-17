class FeedbacksController < ApplicationController
  def upload_csv
    file = params[:file]
    result = Feedbacks::CsvImporter.call(file)
    redirect_to root_path, notice: "#{result[:success]} successfull imports. couldn't import: #{result[:failed]}"
  end

  def upload_csv_form
  end

  def create
    @product = Product.find(params[:product_id])
    @feedback = @product.feedbacks.new(feedback_params)
    @feedback.user = current_user if defined?(current_user)

    if @feedback.save
      redirect_to @product, notice: "feedback submitted"
    else
      flash[:alert] = "something went wrong"
      redirect_to @product
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:rating, :comment)
  end
end
