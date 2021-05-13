# Commpeak_test

Commpeak_test is a test project built by Ruby on Rails.
## Installation



```bash
bundle install
EXPORT DB_PASSWORD="your postgresql password"
bundle exec rails db:setup
bundle exec rails s
```

## What I implemented

- User authentication and authorization
    1. User authentication via email and password
    2. User authorization by role (basic and manager)

- Tickets CRUD management
    1. Ticket model has `name`, `email`, `subject`, `content` and `status` attributes and belongs to User
    2. Save new submitted ticket to CSV file
    3. Import CSV file and save records to model
    4. View for tickets management (new, edit, update, delete, change status)
    5. Search and filter for tickets across all attributes
    6. Resolved tickets can't be applied without a comment
    7. Tickets management by user role
        1. Basic user can't create, edit, update, delete and change status
        2. Manager user can do all actions

- Comments CRUD management
    1. Comment model has `text` attribute and belongs to Ticket
    2. Only manager user can perform comments CURD actions

- RSpec test for models and requests

## How to test

I added seed data for basic and manager users so you can test everything with each user.
- For basic user role, please sign in with `basic@commpeak.com` email and `password` password
- For manager user role, please sign in with `manager@commpeak.com` email and `password` password

Please make sure if all test is passed by following in terminal
``` bash
rspec
```
 