# -*- encoding : utf-8 -*-
TweetStream.configure do |config|
  config.consumer_key = "HHPM3KuA3Q3G7W5s9qTOLw"
  config.consumer_secret = "HBUJxOUo7YLlfskUPDJQnJZeFrJCjDLDqhhGVCBJs"
  config.oauth_token = "112754479-JabWqZpzcZS3Zvf4K9xqwYaGR0qIg63w5TF2oGs8"
  config.oauth_token_secret = "ub5jAiGiLGbdHelSViPvhSy0DDtrJ4z1T5FhxQPYw0"
end

require 'tweetstream'
Daemons.call(multiple: true, monitor: true) do
  tag = Hashtag.active
  TweetStream::Client.new.track '#love' do |status|
    puts status.text if status.media.count > 0
    status.media.each do |photo|
      tag.images.create(
          provider: 'twitter',
          image_link: photo.media_url,
          post_url: photo.url,
          auth: Auth.find_by_uid(status.user.id.to_s) || Auth.create(uid: status.user.id.to_s, name: status.user.name, url: %(http://twitter.com/#{status.user.screen_name}), provider: "twitter"),
          service_id: status.id
      )
    end
  end
end unless Rails.env.development?
