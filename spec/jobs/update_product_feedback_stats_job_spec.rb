require 'rails_helper'

RSpec.describe UpdateProductFeedbackStatsJob, type: :job do
  let(:product) { Product.create!(name: "TV", description: "New TV") }

  it "updates product average_rating and feedback_count" do
    Feedback.create!(rating: 4, product: product)
    Feedback.create!(rating: 5, product: product)
    Feedback.create!(rating: 3, product: product)

    expect(product.average_rating).to eq(0)
    expect(product.feedback_count).to eq(0)

    UpdateProductFeedbackStatsJob.perform_now(product.id)
    product.reload

    expect(product.average_rating).to eq(4.0)
    expect(product.feedback_count).to eq(3)
  end
end
