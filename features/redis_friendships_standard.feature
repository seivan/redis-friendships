Feature: Redis Friendship Generator
  In order to befriend multiple users
  As a rails developer
  I want to generate a Friendship library

  Scenario: Generate default Friendship
    Given a new Rails app
    When I run "rails g redis_friendships"
    Then I should see the following files
       | app/models/friendship.rb  |
	And I should see "class Friendship" in file "app/models/friendship.rb"

	And I should see "def self.follow!(username, followed_username)" in file "app/models/friendship.rb"
	And I should see "R.sadd("friendship:#{username}:followings", followed_username)" in file "app/models/friendship.rb"
	And I should see "R.sadd("friendship:#{followed_username}:followings", username)" in file "app/models/friendship.rb"

    And I should see "def self.stop_following!(username, followed_username)" in file "app/models/friendship.rb"
    And I should see "R.srem("friendship:#{username}:followings", followed_username)" in file "app/models/friendship.rb"
    And I should see "R.srem("friendship:#{followed_username}:followings", username)" in file "app/models/friendship.rb"

	And I should see "def self.follows?(username, followed_username)" in file "app/models/friendship.rb"
    And I should see "R.sismember("friendship:#{username}:followings", followed_username)" in file "app/models/friendship.rb"

  	And I should see "def self.followed_by?(user, following_user)" in file "app/models/friendship.rb"
  	And I should see "  R.sismember("friendship:#{username}:followers", following_username)" in file "app/models/friendship.rb"    

	And I should see "def self.followings_for(username)" in file "app/models/friendship.rb"
  	And I should see "R.smembers("friendship:#{username}:followings")" in file "app/models/friendship.rb"

  	And I should see "def self.followers_for(username)" in file "app/models/friendship.rb" 
  	And I should see "R.smembers("friendship:#{username}:followers")" in file "app/models/friendship.rb"

	And I should see the following files
		|app/models/user.rb|
	And I should see "class User < ActiveRecord::Base" in file "app/models/user.rb"

  	And I should see "def followed_by?(user)" in file "app/models/user.rb"
  	And I should see "Friendship.followed_by?(self.username, user.username)" in file "app/models/user.rb"

  	And I should see "def follows?(user)" in file "app/models/user.rb"
  	And I should see "Friendship.follows?(self.username, user.username)" in file "app/models/user.rb"
 
  	And I should see "def follow!(user)" in file "app/models/user.rb"
 	And I should see "return false if self.username == user.username" in file "app/models/user.rb"
	And I should see "Friendship.follow!(self.username, user.username)" in file "app/models/user.rb"
	And I should see "true" in file "app/models/user.rb"
  
	And I should see "def stop_following!(user)" in file "app/models/user.rb"
	And I should see "Friendship.stop_following!(self.username, user.username)" in file "app/models/user.rb"
  
	And I should see "def followers" in file "app/models/user.rb"
	And I should see "followers = Friendship.followers_for(self.username)" in file "app/models/user.rb"
	And I should see "User.where(:username => followers)" in file "app/models/user.rb"

	And I should see "def followings" in file "app/models/user.rb"
	And I should see "followings = Friendship.followings_for(self.username)" in file "app/models/user.rb"
	And I should see "User.where(:username => followings)" in file "app/models/user.rb"
	And I should not see file "temp_file.rb"

