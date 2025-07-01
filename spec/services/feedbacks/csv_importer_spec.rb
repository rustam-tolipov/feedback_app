require 'rails_helper'
require 'tempfile'

RSpec.describe Feedbacks::CsvImporter do
  describe ".call" do
    let!(:product) { Product.create!(name: "Macbook", description: "cool laptop") }
    let!(:user) { User.create!(name: "maxim", email: "maxim@test.com") }

    def create_csv(content)
      file = Tempfile.new([ "feedbacks", ".csv" ])
      file.write(content)
      file.rewind
      file
    end

    it "imports valid data with explicit product_id" do
      csv_data = <<~CSV
        rating,comment
        5,"Excellent product"
        4,"Good enough"
      CSV

      file = create_csv(csv_data)
      result = described_class.call(file, product.id)

      expect(result[:imported]).to eq(2)
      expect(result[:failed]).to be_empty
      expect(Feedback.count).to eq(2)
      expect(Feedback.first.product_id).to eq(product.id)
    end

    it "falls back to row product_id if global product_id not given" do
      other_product = Product.create!(name: "iPad", description: "Tablet")

      csv_data = <<~CSV
        rating,comment,product_id
        5,"Nice",#{other_product.id}
      CSV

      file = create_csv(csv_data)
      result = described_class.call(file, nil)

      expect(result[:imported]).to eq(1)
      expect(Feedback.first.product_id).to eq(other_product.id)
    end

    it "picks random product if no product info available" do
      Product.create!(name: "RandomOne", description: "Backup")

      csv_data = <<~CSV
        rating,comment
        3,"No product ID"
      CSV

      file = create_csv(csv_data)
      result = described_class.call(file, nil)

      expect(result[:imported]).to eq(1)
      expect(Feedback.first.product).to be_present
    end

    it "returns error if file is blank" do
      result = described_class.call(nil, product.id)

      expect(result[:imported]).to eq(0)
      expect(result[:failed]).to eq([ "File is blank" ])
    end

    it "assigns a random user if not specified in CSV" do
      csv_data = <<~CSV
        rating,comment
        5,"Anonymous user"
      CSV

      file = create_csv(csv_data)
      result = described_class.call(file, product.id)

      expect(result[:imported]).to eq(1)
      expect(Feedback.last.user).to be_present
    end
  end
end
