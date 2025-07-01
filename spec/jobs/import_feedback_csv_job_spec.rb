require 'rails_helper'

RSpec.describe ImportFeedbackCsvJob, type: :job do
  let!(:product) { Product.create!(name: "Mouse", description: "Gaming mouse") }

  it "imports feedbacks from a valid CSV file" do
    csv = <<~CSV
      rating,comment,product_id,user_id
      5,Good,#{product.id},
      4,Not bad,#{product.id},
    CSV

    file_path = Rails.root.join("tmp", "test_feedbacks_#{SecureRandom.hex(4)}.csv")
    File.write(file_path, csv)

    expect {
      described_class.perform_now(file_path.to_s)
    }.to change { Feedback.count }.by(2)
  end
end
