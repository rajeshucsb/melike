require 'rubygems'
require 'koala'

class GraphApiMethods
  def initialize(cookies)
    @graph     = Koala::Facebook::GraphAPI.new
    @oauth     = Koala::Facebook::OAuth.new('105020132906712', '962612f7efff4c587629a7c800453c06')
    @user_info = @oauth.get_user_info_from_cookies(cookies)
    @graph     = Koala::Facebook::GraphAPI.new(@user_info['access_token'])
  end

  def get_friends
    friends = @graph.get_connections("me", "friends")
    friends.sort {|a, b| p a; a["name"] <=> b["name"]}
  end

  def get_likes(friend_id)
    my_likes = @graph.get_connections("me", "likes")
    friend_likes = @graph.get_connections(friend_likes, "likes")
    p my_likes
    p friend_likes

    common = my_likes & friend_likes
    p common
    common
  end
end