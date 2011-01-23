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
    @graph.get_connections("me", "friends")
  end

  def get_likes
  end
end