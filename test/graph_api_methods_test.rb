require "rubygems"
require "test/unit"
require "mocha"
require File.join(File.dirname(__FILE__), "..", 'graph_api_mehods')

class GraphApiMethodsTest < Test::Unit::TestCase
  def setup
    Koala::Facebook::OAuth.stubs(:new).returns(stub(:get_user_info_from_cookies => {"access_token" => "access_token"}))
  end

  def test_get_friends
    friends = [{"name" => "jon", "id" => "3566778"}, {"name" => "zach", "id" => "45886778"}, {"name" => "abraham", "id" => "856886778"}]
    Koala::Facebook::GraphAPI.stubs(:new).returns(stub(:get_connections => friends))

    sorted_friends = GraphApiMethods.new("cookie").get_friends
    assert_equal ["abraham", "jon", "zach"], sorted_friends.map {|fr| fr["name"]}
    assert_equal ["856886778", "3566778", "45886778"], sorted_friends.map {|fr| fr["id"]}
  end

  def test_get_likes
    mock = mock()

    my_likes = [
      {"name" => "Puzzle Master", "id" => "23456"},
      {"name" => "TechCrunch", "id" => "4523456"},
      {"name" => "Facebook", "id" => "8623456"},
    ]

    friend_likes = [
      {"name" => "TechCrunch", "id" => "4523456"},
      {"name" => "Orkut", "id" => "7623456"},
      {"name" => "Puzzle Master", "id" => "23456"},
    ]

    mock.expects(:get_connections).with("me", "likes").returns(my_likes)
    mock.expects(:get_connections).with("friend_id", "likes").returns(friend_likes)

    Koala::Facebook::GraphAPI.expects(:new).returns(mock)

    common_likes =  GraphApiMethods.new("cookie").get_likes("friend_id")

    assert common_likes.include?("TechCrunch")
    assert common_likes.include?("Puzzle Master")
    assert !common_likes.include?("Orkut")
    assert !common_likes.include?("Facebook")
  end
end