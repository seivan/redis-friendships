  def followed_by?(user)
    <%=friendship_class_name%>.followed_by?(self.username, user.username)
  end

  def follows?(user)
    <%=friendship_class_name%>.follows?(self.username, user.username)
  end

  def follow!(user)
    return false if self.username == user.username
    <%=friendship_class_name%>.follow!(self.username, user.username)
    true
  end
  
  def stop_following!(user)
      <%=friendship_class_name%>.stop_following!(self.username, user.username)
  end

  
  def followers
    followers = <%= friendship_class_name %>.followers_for(self.username)
    <%= user_class_name %>.where(:username => followers)
  end

  def followings
    followings = <%= friendship_class_name %>.followings_for(self.username)
    <%= user_class_name %>.where(:username => followings)
  end
