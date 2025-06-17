class FeedbacksController < ApplicationController
  def upload_csv
    file = params[:file]
    result = Feedbacks::CsvImporter.call(file)
    redirect_to root_path, notice: "#{result[:success]} successfull imports. couldn't import: #{result[:failed]}"
  end

  def upload_csv_form
  end
end
