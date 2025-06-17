### feedback app

1. I initialize rails 7.2 with sqlite3 and tailwindcss for styling
2. Set up models for User, Product, Feedback
User: simple user
Product: simple product no validation for now
Feedback: I made it for dependent for product, and add validation for rating since it should be between 1..5. Also make optional relation with user, because user migh be signed out or deleted from db. Last thing I removed minitest (to make app ready to use rspec)
3. I setup Rspec to make it more readable and easy for testing. I tested feedback model validation for starting.
4. In order to make sure all models working as intended I added some seeds for (user, product, feedback) and tested with rails c.
5. I set up products controller and displayed all products in root and give them basic style.