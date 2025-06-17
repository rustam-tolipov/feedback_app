require 'rails_helper'
require 'tempfile'

RSpec.describe Feedbacks::CsvImporter do
  describe ".call" do
    let!(:product) { Product.create!(name: "Macbook", description: "cool laptop") }
    let!(:user) { User.create!(name: "maxim", email: "maxim@test.com") }

    def create_csv(content)
      file = Tempfile.new(["feedbacks", ".csv"])
      file.write(content)
      file.rewind
      file
    end

    it "should import if the valida data given" do
      csv_data = <<~CSV
        rating,comment,product_id,user_id
        5,"Excellent product",#{product.id},#{user.id}
        4,"Good enough",#{product.id},#{user.id}
      CSV

      file = create_csv(csv_data)
      result = described_class.call(file)

      expect(result).to eq({ success: 2, failed: 0 })
      expect(Feedback.count).to eq(2)
    end

    it "should show error if file is not present" do
      result = described_class.call(nil)
      expect(result).to eq({ success: 0, failed: 1 })
    end

    it "should accept without user" do
      file = create_csv(<<~CSV)
        rating,comment,product_id,user_id
        3,user not added,#{product.id},
      CSV

      result = described_class.call(file)

      expect(result[:success]).to eq(1)
      expect(Feedback.last.user_id).to be_nil
    end
  end
end
