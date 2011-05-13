require "rubygems"
require "bundler/setup"

require "tweetstream"
require "mongo"
require "time"
require "json"

# HTTP basic auth...tweetstream doesn't seem to do OAuth
# but twitter is going to require OAuth very soon now.
# There is a patch for tweetstream to do OAuth which we
# could probably merge in and then send a pull request.
stream = TweetStream::Client.new('devscoop','k3H*h1js7674s3$HOz0')

db = Mongo::Connection.new("localhost", 27017).db("social-manager")
tweets = db.collection("tweets")

stream.on_error do |message|
  puts message
  exit
end

stream.on_delete do |status_id, user_id|
  tweets.remove('tweet_id' => status_id)
end

stream.track("hootsuite", "sproutsocial") do |status|
  puts "======================\r\n"
  puts status.to_s + "\r\n"
  
  tweet = {
    "tweet_id" => status.id,
    "created_at" => Time.parse(status.created_at),
    "text" => status.text,
    "geo" => status.geo,
    "coordinates" => status.coordinates,
    "retweeted" => status.retweeted,
    "urls" => status.entities.urls,
    "mentions" => status.entities.user_mentions.map{|m| {"screen_name" => m[:screen_name], "id" => m[:id]}},
    "hashtags" => status.entities.hashtags,
    "user" => {"screen_name" => status.user.screen_name, "id" => status.user.id, "followers_count" => status.user.followers_count},
    "in_reply_to_status_id" => status.in_reply_to_status_id 
  }
  
  tweets.insert(tweet);
end