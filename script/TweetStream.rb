require 'daemons'
Daemons.new_proc 'tracker' do
require File.expand_path('../../config/environment', __FILE__)
require 'rubygems'
require 'active_record'


TweetStream.configure do |config|
  config.consumer_key = "HHPM3KuA3Q3G7W5s9qTOLw"
  config.consumer_secret = "HBUJxOUo7YLlfskUPDJQnJZeFrJCjDLDqhhGVCBJs"
  config.oauth_token = "112754479-JabWqZpzcZS3Zvf4K9xqwYaGR0qIg63w5TF2oGs8"
  config.oauth_token_secret = "ub5jAiGiLGbdHelSViPvhSy0DDtrJ4z1T5FhxQPYw0"
end
tag = HashTag.first
  TweetStream::Client.new.track('#'+tag.tag) do |status|
    status.media.each do |photo|
      tag.images.create(
          provider_id: 2,
          when_published: Time.now,
          url: photo.media_url,
          author_id: status.from_user,
          post_id: status.id
      )
    end
  end
end