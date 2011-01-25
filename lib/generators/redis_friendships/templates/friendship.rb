class <%= friendship_class_name %>

  def self.follow!(username, followed_username)
    <%=redis_constant_name%>.sadd("<%=friendship_singular_name%>:#{username}:followings", followed_username)
    <%=redis_constant_name%>.sadd("<%=friendship_singular_name%>:#{followed_username}:followings", username)
  end
  
  def self.stop_following!(username, followed_username)
    <%=redis_constant_name%>.srem("<%=friendship_singular_name%>:#{username}:followings", followed_username)
    <%=redis_constant_name%>.srem("<%=friendship_singular_name%>:#{followed_username}:followings", username)
  end

  def self.follows?(username, followed_username)
    <%=redis_constant_name%>.sismember("<%=friendship_singular_name%>:#{username}:followings", followed_username)
  end

  def self.followed_by?(user, following_user)
    <%=redis_constant_name%>.sismember("<%=friendship_singular_name%>:#{username}:followers", following_username)    
  end

  def self.followings_for(username)
    <%= redis_constant_name %>.smembers("<%= friendship_singular_name %>:#{username}:followings")
  end

  def self.followers_for(username)
    <%= redis_constant_name %>.smembers("<%= friendship_singular_name %>:#{username}:followers")
  end

end