require 'rubygems'
require 'koala'

class GraphApiMethods
  def initialize
    @graph = Koala::Facebook::GraphAPI.new
  end

  def get_friends
    return session
  end

  def get_likes
  end
end