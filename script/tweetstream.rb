# -*- encoding : utf-8 -*-
require 'active_record'
ActiveRecord::Base.establish_connection YAML::load(File.open 'config/database.yml')[ENV["RAILS_ENV"] ||= 'development']


class Image < ActiveRecord::Base
  attr_accessible :image_link, :likes_count, :created_at, :provider, :service_id, :hashtag, :post_url, :auth, :likes_count
  belongs_to :hashtag
  belongs_to :auth, foreign_key: :author_id
end
class Hashtag < ActiveRecord::Base
  attr_accessible :tag, :start_time, :images
  has_many :images

  def self.active
    Hashtag.where('start_time < ?', Time.now).order('"start_time" DESC').first
  end
end
class Auth < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :data, :url, :images, :is_subscribed, :accepted_deal, :images, :own_images
  has_many :own_images, class_name: :Image, foreign_key: :author_id
  validates_uniqueness_of :uid, scope: :provider
  validates_uniqueness_of :url, scope: :provider
end
require 'tweetstream'
require 'oj'
TweetStream.configure do |config|
  config.consumer_key = "HHPM3KuA3Q3G7W5s9qTOLw"
  config.consumer_secret = "HBUJxOUo7YLlfskUPDJQnJZeFrJCjDLDqhhGVCBJs"
  config.oauth_token = "112754479-JabWqZpzcZS3Zvf4K9xqwYaGR0qIg63w5TF2oGs8"
  config.oauth_token_secret = "ub5jAiGiLGbdHelSViPvhSy0DDtrJ4z1T5FhxQPYw0"
  config.auth_method = :oauth
  config.parser = Oj
end

@tag = Hashtag.active
client = TweetStream::Client.new
client.on_timeline_status do |status|
  if (status.hashtags.any?{|h| h[:text].downcase == @tag.tag} and !status.retweet?)
  status.media.each do |photo|
      puts @tag.images.create(
          provider: 'twitter',
          image_link: photo.media_url,
          post_url: photo.url,
          auth: Auth.find_by_uid(status.user.id.to_s) || Auth.create(uid: status.user.id.to_s, name: status.user.name, url: %(http://twitter.com/#{status.user.screen_name}), provider: "twitter"),
          service_id: status.id
      )
    end
  end

end
client.track '#' + @tag.tag