namespace :products do
  desc "This helps to manually change average_rating and feedback_count manualy with rake task"
  task recalculate_stats: :environment do
    Product.find_each do |product|
      avg = product.feedbacks.average(:rating).to_f.round(2)
      count = product.feedbacks.count
      product.update_columns(average_rating: avg, feedback_count: count)
    end
    puts "Product stats (feedback_count and average_rating) updated."
  end
end
