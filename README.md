# README

This documentation describes how to set up the application, its components, how
to deploy it, and some internal information.

## Set up
This application needs ruby version 2.6.3. The version is set at the top of the
Gemfile, in a way similar to Heroku. Most ruby version managers and Heroku
recognize this syntax and will select the right version, or ask to install it.
To find more about ruby, go [here](https://www.ruby-lang.org/es/)

This application is also based on the latest stable Rails version, which is, at
this moment, 6.0.0. To find more about Rails, go [here](http://rubyonrails.org/)

This application also depends on node.js and yarn. You need at least node.js version 8.16.0+, and
yarn version 1.x+. To learn more about how to install node.js go to [their website](https://nodejs.org/).

Once you have node.js installed you can install yarn by running:

    sudo npm install -g yarn@">=1.0" 

Then, you have to install all the gem dependencies. To do so, run:

    gem install bundler
    bundle install

After that, your application is ready to go. To run it, you have to execute:

    rails s

Point your browser to [http://localhost:3000/](http://localhost:3000/) and explore!

## Deployment instructions
This application is Heroku-ready. To deploy it to heroku, you have to first set
up an application on Heroku, and add Heroku as a remote with this:

    heroku git:remote -a your-app-name

After that, you only have to push it to Heroku:

    git push heroku master

## Internal information

Most of the needed stylesheets are loaded, as standard, from
```assets/stylesheets/application.css```. Almost all the javascripts are loaded,
as standard, from ```assets/javascripts/application.js```, except for some that
have to be loaded directly from the template, as they require some special
attributes.

Each page can accept a ```content_for :head_block``` block which you can use to insert
styles and other types of content into the header HTML section. Also, each page
can accept a ```content_for :scripts_block``` block where you can set page specific
javascript. 

Left side menu is dynamically generated. You can configure it by going to the 
object ```SidebarEntry```
