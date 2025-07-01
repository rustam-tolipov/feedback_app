### feedback app

### improvements after feedback
1. I changes sqlite to postgresql to make application better on using background jobs like table locks.
2. Updated Product table by adding average_rating and feedback_count to use less functions.
3. Instead of using sql functions I used background jobs to handle updating product stats and it can handle large amount of data as well.

1. I initialize rails 7.2 with sqlite3 and tailwindcss for styling
2. Set up models for User, Product, Feedback
User: simple user
Product: simple product no validation for now
Feedback: I made it for dependent for product, and add validation for rating since it should be between 1..5. Also make optional relation with user, because user migh be signed out or deleted from db. Last thing I removed minitest (to make app ready to use rspec)
3. I setup Rspec to make it more readable and easy for testing. I tested feedback model validation for starting.
4. In order to make sure all models working as intended I added some seeds for (user, product, feedback) and tested with rails c.
5. I set up products controller and displayed all products in root and give them basic style.
6. For displaying products with averate score and feedbacks count for each post I used left_joins and set averager_rating based on feedbacks.rating, and feedback_count based on feedbacks.id. I use fat model and skinny controller approach and moved this logic to scope in model.
7. Added searching functionality with turbo stimulus. Filter by rating also implemented, both search and filter can work togather. 
8. Well for uploading reviews(feedbacks), I used simple uploading technique, put the logic in services. To save time I used simple redirect after upload (no turbo). Also, I change user_id to be nullable since we are uploading data and we might not have user id then we can skipp user in this point. But if other areas fails then we see in faild imports.
9. For debugging I first make sure if there are any N+1 query problem with bullet gem
10. I added index for product name and feedback rating to improve performance.
11. I wanted to try kaminari or pagy but after facing couple of issues with setup, I stick with the custom pagination for this. Also directly putting param to route_path I got error so just for this time I use to_unsafe_h
12. I added minimal styling at the end. 

### timing
1. I started working with this project at 11AM UTC+5
2. Approximately 1-2hs took me for planning, working with schema
3. In the rest of 8hs I try to implement step by step, first I try to keep writing test togather. Since it was tooking some time I jump in to working with the project instead. 
4. Turbo frame took a bit of time. Currently project is mixed with traditional page reload and turbo in requested places.
5. For file upload I need to make a desicion wethere upload products with user_id or not.
6. I added indexex to improve the performance. Also joins was a bit tricky for putting them into scope. 
7. the last hours I spent for testing services and queries. Testing csv upload took a bit amount of time.

### instalation
used: rails 7.2, sqlite3, ruby 3.3.1

instalation:
```
bundle install
rails db:create
rails db:migrate
rails db:seed
```

or just
```
rails db:setup
```

added sample csv file in root sample_feedbacks.csv