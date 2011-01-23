require 'rubygems'
require 'koala'

class GraphApiMethods
  def initialize(session)
    @graph = Koala::Facebook::GraphAPI.new
    @session = session
  end

  def get_friends
    return @session
  end

  def get_likes
  end
end