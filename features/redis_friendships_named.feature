Feature: Redis Friendships Generator With Named Models
  In order to send befriend people
  As a rails developer
  I want to generate a fellowship library using fellowship as a name and hobbits as users


  Scenario: Generate named messages
    Given a new Rails app
    When I run "rails g redis_friendships fellowships hobbit Red"
    Then I should see the following files
       | app/models/fellowship.rb  |
	And I should see "class Fellowship" in file "app/models/fellowship.rb"

	And I should see "def self.follow!(username, followed_username)" in file "app/models/fellowship.rb"
	And I should see "Red.sadd("fellowship:#{username}:followings", followed_username)" in file "app/models/fellowship.rb"
	And I should see "Red.sadd("fellowship:#{followed_username}:followings", username)" in file "app/models/fellowship.rb"

    And I should see "def self.unfollow!(username, followed_username)" in file "app/models/fellowship.rb"
    And I should see "Red.srem("fellowship:#{username}:followings", followed_username)" in file "app/models/fellowship.rb"
    And I should see "Red.srem("fellowship:#{followed_username}:followings", username)" in file "app/models/fellowship.rb"

	And I should see "def self.follows?(username, followed_username)" in file "app/models/fellowship.rb"
    And I should see "Red.sismember("fellowship:#{username}:followings", followed_username)" in file "app/models/fellowship.rb"

  	And I should see "def self.followed_by?(user, following_user)" in file "app/models/fellowship.rb"
  	And I should see "Red.sismember("fellowship:#{username}:followers", following_username)" in file "app/models/fellowship.rb"    

	And I should see "def self.followings_for(username)" in file "app/models/fellowship.rb"
  	And I should see "Red.smembers("fellowship:#{username}:followings")" in file "app/models/fellowship.rb"

  	And I should see "def self.followers_for(username)" in file "app/models/fellowship.rb" 
  	And I should see "Red.smembers("fellowship:#{username}:followers")" in file "app/models/fellowship.rb"

	And I should see the following files
		|app/models/hobbit.rb|
	And I should see "class Hobbit < ActiveRecord::Base" in file "app/models/hobbit.rb"

  	And I should see "def followed_by?(user)" in file "app/models/hobbit.rb"
  	And I should see "Fellowship.followed_by?(self.username, user.username)" in file "app/models/hobbit.rb"

  	And I should see "def follows?(user)" in file "app/models/hobbit.rb"
  	And I should see "Fellowship.follows?(self.username, user.username)" in file "app/models/hobbit.rb"
 
  	And I should see "def follow!(user)" in file "app/models/hobbit.rb"
 	And I should see "return false if self.username == user.username" in file "app/models/hobbit.rb"
	And I should see "Fellowship.follow!(self.username, user.username)" in file "app/models/hobbit.rb"
	And I should see "true" in file "app/models/hobbit.rb"
  
	And I should see "def unfollow!(user)" in file "app/models/hobbit.rb"
	And I should see "Fellowship.unfollow!(self.username, user.username)" in file "app/models/hobbit.rb"
  
	And I should see "def followers" in file "app/models/hobbit.rb"
	And I should see "followers = Fellowship.followers_for(self.username)" in file "app/models/hobbit.rb"
	And I should see "Hobbit.where(:username => followers)" in file "app/models/hobbit.rb"

	And I should see "def followings" in file "app/models/hobbit.rb"
	And I should see "followings = Fellowship.followings_for(self.username)" in file "app/models/hobbit.rb"
	And I should see "Hobbit.where(:username => followings)" in file "app/models/hobbit.rb"
	And I should not see file "temp_file.rb"

