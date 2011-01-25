Feature: Redis Messages Generator With Existing User Model
  In order to blablablab this makes testing boring I need to refactor this anyway and I have a cold
  As a rails developer
  I want to inject the messaging code into the existing User model


  Scenario: Generate injected code into existing User Model
    Given a new Rails app
	When I run "rails g model hobbit username:string"
    When I run "rails g redis_friendships fellowships hobbit Red"
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

