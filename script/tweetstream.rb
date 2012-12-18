# -*- encoding : utf-8 -*-

require 'daemons'
Daemons.run_proc('parser.rb') do
require 'active_record'
ActiveRecord::Base.establish_connection YAML::load(File.open '/mnt/data/www/insta.liptontea.ru/config/database.yml')[ENV["RAILS_ENV"] || 'production']


class Image < ActiveRecord::Base
  attr_accessible :image_link, :likes_count, :created_at, :provider, :service_id, :hashtag, :post_url, :auth, :likes_count, :text, :service_time
  belongs_to :hashtag
  belongs_to :auth, foreign_key: :author_id
  before_create {self.likes_count = 0}
  before_create {self.is_blocked = false; true}
  def self.last_instagram_id(hashtag)
    (Image.where(provider: 'instagram', hashtag_id: hashtag).count > 0 ? Image.select(:service_id).where(provider: 'instagram').last.service_id : (Instagram.tag_recent_media(hashtag.tag).data.first.try(:created_at) || 1000)).to_i * 1000
  end
  validates :post_url, uniqueness: true
  validates :image_link, uniqueness: true
end
class Hashtag < ActiveRecord::Base
  attr_accessible :tag, :start_time, :images
  has_many :images

  def self.active
    Hashtag.where('start_time < ?', Time.now).order('"start_time" DESC').first
  end
end
class Auth < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :data, :url, :images, :is_subscribed, :images, :own_images, :avatar_url
  has_many :own_images, class_name: :Image, foreign_key: :author_id
  validates_uniqueness_of :uid, scope: :provider
  validates_uniqueness_of :url, scope: :provider
end

require 'twitter'
Twitter.configure do |config|
  config.consumer_key = "HHPM3KuA3Q3G7W5s9qTOLw"
  config.consumer_secret = "HBUJxOUo7YLlfskUPDJQnJZeFrJCjDLDqhhGVCBJs"
  config.oauth_token = "112754479-JabWqZpzcZS3Zvf4K9xqwYaGR0qIg63w5TF2oGs8"
  config.oauth_token_secret = "ub5jAiGiLGbdHelSViPvhSy0DDtrJ4z1T5FhxQPYw0"
end
require 'instagram'
Instagram.configure do |config|
  config.client_id = "66f96c768dd64b8887d10ae2feb6d1d6"
  config.client_secret = "1906cbd03e674cca92a4480e7bb64adb"
end

parse = lambda { |start_id = 123456789012345|
  answer = Instagram.tag_recent_media(@tag.tag, max_tag_id: start_id, min_tag_id: Image.last_instagram_id(@tag))
  parse.call(answer.pagination.next_max_tag_id.to_i) if answer.pagination.next_max_tag_id.to_i > Image.last_instagram_id(@tag) and answer.data.last.created_time > start_time
  answer.data.reverse.each { |status|
    @tag.images.create(
        provider: 'instagram',
        image_link: status.images.standard_resolution.url,
        post_url: status.link,
        auth: Auth.find_by_uid(status.user.id) || Auth.create(uid: status.user.id, name: status.user.screen_name || status.user.username, url: %(http://instagram.com/#{status.user.username}), provider: "instagram", avatar_url: (status.user.profile_image_url.blank? ? status.user.profile_image_url : "/assets/nopic.png")),
        service_id: status.created_time.to_i,
        text: status.text
    )
  } if answer.data.count > 0
}


loop do
@tag = Hashtag.active
start_time = @tag.start_time.to_i.to_s
Twitter.search(@tag.tag).statuses.reverse.each do |status|
  if status.hashtags.any?{|h| h[:text].downcase == @tag.tag} and !status.retweet?
    puts status.text
    status.media.each do |photo|
      @tag.images.create(
          provider: 'twitter',
          image_link: photo.media_url,
          post_url: photo.url,
          auth: Auth.find_by_uid(status.user.id.to_s) || Auth.create(uid: status.user.id.to_s, name: status.user.name, url: %(http://twitter.com/#{status.user.screen_name}), provider: "twitter", avatar_url: (status.user.profile_image_url.blank? ? status.user.profile_image_url : "/assets/nopic.png")),
          service_id: status.id,
          text: status.text
      )
    end
  end
end
sleep 15
parse.call(@tag.tag)
end
end