# -*- encoding: utf-8 -*-
VERSION = "0.2"

Gem::Specification.new do |s|
  s.name        = "redis-friendships"
  s.version     = VERSION
  s.author      = "Seivan Heidari"
  s.email       = "seivan@kth.se"
  s.homepage    = "http://github.com/seivan/redis-friendships"
  s.summary     = "A friendship library with a certain follower/following system utilizing the power of both Redis and SQL."
  s.description = "A friendship library with a certain follower/following system utilizing the power of both Redis and SQL. Using SQL for the users and Redis for the followers and the followings. Redis uses sets of usernames for both your followers and followings. And can be used to retrieve more information about your e.g. followers from SQL with those unique usernames. "

  s.files        = Dir["{lib,test,features}/**/*", "[A-Z]*"]
  s.require_path = "lib"

  s.add_development_dependency 'rspec-rails', '~> 2.0.1'
  s.add_development_dependency 'cucumber', '~> 0.9.2'
  s.add_development_dependency 'rails', '~> 3.0.0'
  s.add_development_dependency 'mocha', '~> 0.9.8'
  s.add_development_dependency 'bcrypt-ruby', '~> 2.1.2'
  s.add_development_dependency 'sqlite3-ruby', '~> 1.3.1'

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end
