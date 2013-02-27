# recipes
require "plur/capistrano/foreman"
require "plur/capistrano/upstart"
require "plur/capistrano/figaro"

Capistrano::Configuration.instance(:must_exist).load do
  _cset :plur_callback, true
end
