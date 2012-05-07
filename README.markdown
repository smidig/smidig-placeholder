# Smidig 2012, public beta

## Getting started

### Requirements

* Ruby
* git
* bundler (gem install bundler)

### Local Environment

Grab your copy and install depencies:

    git clone http://github.com/USERNAME/smidig-placeholder
    cd smidig-placeholder
    bundle install

Start server on http://localhost:3000

    rackup -p 3000

## Deployment to Heroku

Do once:

    $ git remote add production git@heroku.com:smidig2012pre.git

To deploy:

    $ git push production

