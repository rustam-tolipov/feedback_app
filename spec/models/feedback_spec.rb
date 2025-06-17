require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:product) { Product.create!(name: "Laptop", description: "some laptop")}

  it "is valid with a rating between 1 to 5" do
    feedback = Feedback.new(rating: 4, product: product)
    expect(feedback).to be_valid
  end

  it "not valid if it's not in 1-5 range" do
    feedback = Feedback.new(rating: 6, product: product)
    expect(feedback).to be_invalid
  end

  it "while we uploading review csv then we donot need users to be present in this case user nil can be true" do
    feedback = Feedback.new(rating: 5, product: product)
    expect(feedback).to be_valid
    expect(feedback.user_id).to be_nil
  end
end
