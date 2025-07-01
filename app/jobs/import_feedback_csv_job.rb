class ImportFeedbackCsvJob < ApplicationJob
  queue_as :default

  def perform(file_path, product_id = nil)
    return unless File.exist?(file_path)

    file = File.open(file_path)
    result = Feedbacks::CsvImporter.call(file, product_id)
    file.close
    File.delete(file_path)

    Rails.logger.info "CSV Import: #{result[:imported]} imported, #{result[:failed].size} failed"
  rescue => e
    Rails.logger.error("CSV Import failed: #{e.message}")
  end
end
