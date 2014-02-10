## FilmedHere Web Application
This web application displays San Francisco filming locations on a map. It is deployed [here](http://filmedhere.herokuapp.com/).

#### Technology stack, tools, services and experience
- **Ruby** 2.0.0p195 - I have been programming in Ruby occasionally for the past couple of years. I am definitely not an expert, but I am starting to appreciate the expressiveness of the language.
- **Rails** 4.0.2 - I have been using Rails for about 2 years. I have spent a fair bit of time digging into the nuances of the framework. It is great for quick prototyping, but I have not tried building any complex applications on rails.
- **Backbone.js** - I had never used backbone.js before working on FilmedHere. While I understand the basics, I think it will take me a few more applications to unlock the full potential of the framework. Also, I did not get a chance to explore any testing frameworks for backbone.js.
- **Coffeescript** - In hindsight, learning coffeescript along with backbone.js in a couple of days, was probably not the smartest idea. But, I was pleasantly surprised by the clarity and readability of coffeescript. 
- **Rspec** - I have been using rspec since I started working with rails. For important applications, I prefer to use test driven development because it ensures high coverage. However, for personal projects or prototypes, I usually just write tests for the important aspects of the application. 
- **Twitter Bootstrap** - I used Twitter Bootstrap to style the app. Almost always, I end up using themes from Wrapbootstrap to give the app a more distinctive look. But, I decided against it this time around in the interest of time.
- **Heroku** - Deploying a rails app is simple and painless with heroku. So, I decided to use the service again.  
- **Google Maps API** - I had never worked with the Google Maps API prior to working on FilmedHere. It is reasonably well documented, which makes it easy to setup.
- **Webmock** - I used a tool called Webmock to mock web service responses in the test environment to speed up the tests and also to avoid hitting API limits.
- **HTTParty** - I used HTTParty as the HTTP client to send requests out to Google Places and SF Data.
- **jquery-ui Autocomplete** - Autocompletion is handled on the client side using jquery-ui autocomplete.  

**Note**: See /Gemfile for a complete list of dependencies

#### Strategy
Instead of fetching the latest filming location data each time from the SF data server, I decided to store the filming location data on the FilmedHere server. So, the strategy is to fetch the latest filming location data periodically and then resolving and persisting the exact location of any new filming locations. This strategy has three advantages - Firstly, FilmedHere does not need to depend on the availability of the SF Data server. Secondly, exact location of the filming location can be resolved once and then persisted. This minimizes external requests to the Google Places API. Finally, fetching preprocessed data from our database should be faster than making a bunch of external calls to SF Data and Google Places. Currently, we need to run the update task manually, but it can easily be setup as a periodic background job, if needed.

Backbone.js handles the client side interactions. When the page is initally loaded, it fetches all the films with associated location data and puts it in a collection. While this is not ideal for a large set of locations, this strategy should work fine for the current set of filming locations. The initial experience is a bit overwhelming because it loads a ton of markers on the page. But, then the user has the ability to select locations for a specific film using the search control. The search input also has autocomplete functionality to help the user find available films. The source array for the search control autocomplete is built using the data that was populated into the films collection. When the user searches for a specific film, only markers for the locations associated with that film are displayed.

#### Testing
Most of the tests were created as a result of scaffolding. But, tests for the service classes have been developed from scratch.
These tests can be found in /spec/services. The spec for FilmingLocationService ensures that records are created as expected when new filming location data is available. Webmock is used to stub the requests going out to SF Data and GooglePlaces. The logic to mock these requests and responses can be found in /spec/spec_helper.rb in the config section.
I did not have enough time to explore testing options for backbone.js, but I plan to definitely look into it for future projects.  

#### Navigating this repository
1. Service classes are located in the **/app/services** folder
2. Backbone.js classes are located in the **/app/assets/javascripts** folder
3. Controllers are located in the **/app/controllers** folder
4. Models are located in the **/app/models** folder
5. Views are located in the **/app/views** folder
6. Database adapter details are located in **/config/database.yml**
7. Routes are located in **/config/routes.rb**
8. Database migrations are located in **/db/migrate** folder
9. Database schema is located in **/db/schema.rb**
10. All test files are located in **/spec** folder
11. Dependency information is located in **/Gemfile**

#### Configuration
Run bundle install to install all the dependencies

    $ bundle install

#### Database creation
1. Create a database user for the app

        $ createuser filmedhere

2. Create the development, test, and production databases

        $ createdb -Ofilmedhere -Eunicode filmedhere_development
        $ createdb -Ofilmedhere -Eunicode filmedhere_test
        $ createdb -Ofilmedhere -Eunicode filmedhere_production


#### Database initialization
Migrate the database after it has been setup

    $ rake db:migrate

#### How to run the test suite
1. Install rspec

        $ bundle install
        $ rails generate rspec:install

2. Then, delete the test folder in rails.
3. Create a binstub for the rspec command

        $ bundle binstubs rspec-core

4. Check whether you can run the test suite

        $ rspec

#### Services
The app uses 3 services:

1. **FilmingLocationService** - creates records in the database based on the latest filming location information
2. **GooglePlacesService** - fetches lat long and other relevant information about a location
3. **SFDataService** - fetches information about the latest filming locations in San Francisco

#### Deployment instructions
Run the following command in the app directory

        $ git push heroku master

#### Reporting issues
Please report any issues [here](https://github.com/sionc/filmedhere/issues).

#### Detailed setup instructions 
For detailed setup instructions for such apps, check out [sionc/rails-postgres-backbone-bootstrap-bootswatch](https://gist.github.com/sionc/8574230)

