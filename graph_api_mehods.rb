require 'rubygems'
require 'koala'

class GraphApiMethods
  def initialize(cookies)
    @oauth     = Koala::Facebook::OAuth.new('105020132906711', '962612f7efff4c587629a7c800453c05')
    @user_info = @oauth.get_user_info_from_cookies(cookies)
    @graph     = Koala::Facebook::GraphAPI.new(@user_info['access_token'])
  end

  def get_friends
    friends = @graph.get_connections("me", "friends")
    friends.sort {|a, b| a["name"] <=> b["name"]}
  end

  def get_likes(friend_id)
    my_likes = @graph.get_connections("me", "likes")
    friend_likes = @graph.get_connections(friend_id, "likes")

    my_likes_ids = my_likes.map {|like| like["id"]}
    friend_likes_ids = friend_likes.map {|like| like["id"]}

    my_likes_map = get_id_name_map(my_likes)

    common_ids = my_likes_ids & friend_likes_ids
    common_ids.map {|id| my_likes_map[id]}
  end

  private

  def get_id_name_map(likes)
    id_name_map = {}
    likes.each do |like|
      id_name_map[like["id"]] = like["name"]
    end

    id_name_map
  end
end