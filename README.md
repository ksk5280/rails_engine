# Rails Engine

This project uses Rails and ActiveRecord to build a JSON API

## Data Importing

Run the following commands from your terminal:

Clone the repo and import the database
  * `git clone git@github.com:ksk5280/rails_engine.git`
  * `cd rails_engine`

Install required gems from the Gemfile
  * `bundle install`
 
Create the database and import the project's csv data
* `rake db:create db:migrate import`


## Testing with RSpec

Run the tests with the command `rspec`
