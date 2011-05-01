require "rubygems"
require "bundler/setup"

require "tweetstream"

# HTTP basic auth...tweetstream doesn't seem to do OAuth
# but twitter is going to require OAuth very soon now.
# There is a patch for tweetstream to do OAuth which we
# could probably merge in and then send a pull request.
stream = TweetStream::Daemon.new('reluthan','########', 'Devscoop')

stream.track('mirror', 'monkey') do |status|
  puts status
end