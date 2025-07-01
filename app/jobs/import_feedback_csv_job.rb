class ImportFeedbackCsvJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    return unless File.exist?(file_path)

    file = File.open(file_path)
    result = Feedbacks::CsvImporter.call(file)
    file.close
    File.delete(file_path)

    Rails.logger.info "CSV Import: #{result[:success]} success, #{result[:failed]} failed"
  rescue => e
    Rails.logger.error("CSV Import failed: #{e.message}")
  end
end
