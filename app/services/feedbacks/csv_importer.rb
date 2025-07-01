require "csv"

module Feedbacks
  class CsvImporter
    def self.call(file, product_id)
      new(file, product_id).import
    end

    def initialize(file, product_id)
      @file = file
      @product_id = product_id
      @imported = 0
      @failed = []
    end

    def import
      return { imported: 0, failed: [ "File is blank" ] } if @file.blank?

      selected_product = Product.find_by(id: @product_id)

      CSV.foreach(@file.path, headers: true) do |row|
        product =
          if selected_product.present?
            selected_product
          elsif row["product_id"].present?
            Product.find_by(id: row["product_id"])
          else
            Product.all.sample
          end

        feedback = Feedback.new(
          rating:  row["rating"],
          comment: row["comment"],
          user:    User.all.sample,
          product: product
        )

        if feedback.save
          @imported += 1
        else
          @failed << "Failed to import feedback for product ID #{product&.id || row["product_id"] || 'unknown'}"
        end
      end

      { imported: @imported, failed: @failed }
    end
  end
end
