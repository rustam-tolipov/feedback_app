class FeedbacksController < ApplicationController
  def upload_csv
    if params[:file].present?

      # So in case if someone deletes the importing file I'm saving it as temp file and deleting after import is done.
      uploaded_file = params[:file]
      filename = Rails.root.join("tmp", "uploads", "#{SecureRandom.hex(8)}.csv")
      FileUtils.mkdir_p(File.dirname(filename))
      File.write(filename, uploaded_file.read)

      ImportFeedbackCsvJob.perform_later(filename.to_s)

      redirect_to root_path, notice: "CSV upload started. Feedbacks will be imported shortly."
    else
      redirect_to root_path, alert: "Please upload a CSV file."
    end
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
