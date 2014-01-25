## FilmedHere Web Application
This web application displays San Francisco filming locations on a map.

#### Technology stack details
- **Ruby** 2.0.0
- **Rails** 4.0.2

**Note**: See /Gemfile for more details

#### System dependencies

#### Configuration

#### Database creation
1. Create a database user for the app

        $ createuser filmedhere

2. Create the development, test, and production databases

        $ createdb -Ofilmedhere -Eunicode filmedhere_development
        $ createdb -Ofilmedhere -Eunicode filmedhere_test
        $ createdb -Ofilmedhere -Eunicode filmedhere_production


#### Database initialization

#### How to run the test suite
1. Install rspec

        $ bundle install
        $ rails generate rspec:install

2. Then, delete the test folder in rails.
3. Create a binstub for the rspec command

        $ bundle binstubs rspec-core
4. Check whether you can run the test suite

        $ rspec

#### Services (job queues, cache servers, search engines, etc.)

#### Deployment instructions

#### Detailed setup instructions 
For detailed setup instructions for such apps, check out [sionc/rails-postgres-backbone-bootstrap-bootswatch](https://gist.github.com/sionc/8574230)

