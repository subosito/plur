# Plur

Opinionated development workflow and commonly used tools for Ruby on Rails based development.

![Logo](https://raw.github.com/subosito/plur/master/images/slank-plur.png)

## Installation

As usual, add the gem into your Gemfile:

    gem 'plur'

## Usage

Currently there are two parts on this gem, deployment and helper:

### Deployment

If you're using [Capistrano](https://github.com/capistrano/capistrano), [Figaro](https://github.com/laserlemon/figaro), [Foreman](https://github.com/ddollar/foreman), and deploy it into Ubuntu box or any OS that use [Upstart](http://upstart.ubuntu.com), then you're on right track :). Just Add to your `deploy.rb`:

    # deploy.rb
    require 'plur/capistrano'

    #
    ## default
    #

    # foreman
    set :foreman_format,      "upstart"
    set :foreman_location,    "/etc/init"
    set :foreman_procfile,    "Procfile"
    set :foreman_root,        release_path
    set :foreman_port,        5000
    set :foreman_app,         application
    set :foreman_user,        user
    set :foreman_log,         'shared_path/log'
    set :foreman_concurrency, false

    # figaro
    set :figaro_yaml,     true
    set :figaro_symlink,  true
    set :figaro_output,   'shared_path/application.yml'
    set :figaro_config,   'latest_release/config/application.yml'

    # upstart
    set :service_name, application

If you like to locally precompile assets to reduce load on server, you can add:

    # deploy.rb
    require 'plur/capistrano/local'

### Helpers

By default Plur will install several helpers, see [view.rb](https://github.com/subosito/plur/blob/master/lib/plur/helpers/view.rb):

    - current_locale
    - rtl_locales
    - rtl?
    - orientation
    - notifications
    - namespace_name
    - body_attributes
    - build_html

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

