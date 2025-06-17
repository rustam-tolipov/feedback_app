require 'csv'

module Feedbacks
  class CsvImporter
    def self.call(file)
      new(file).import
    end

    def initialize(file)
      @file = file
      @success_count = 0
      @failure_count = 0
    end

    def import
      return { success: 0, failed: 1 } unless @file

      CSV.foreach(@file.path, headers: true) do |row|
        feedback = Feedback.new(
          rating: row["rating"],
          comment: row["comment"],
          product_id: row["product_id"],
          user_id: row["user_id"].presence
        )

        if feedback.save
          @success_count += 1
        else
          @failure_count += 1
        end
      end

      { success: @success_count, failed: @failure_count }
    end
  end
end
