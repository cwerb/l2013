# -*- encoding : utf-8 -*-
require 'active_record'
ActiveRecord::Base.establish_connection YAML::load(File.open 'config/database.yml')[ENV["RAILS_ENV"] || 'production']

class Image < ActiveRecord::Base
  attr_accessible :image_link, :likes_count, :created_at, :provider, :service_id, :hashtag, :post_url, :auth, :likes_count, :text
  belongs_to :hashtag
  belongs_to :auth, foreign_key: :author_id
  validates :image_link, uniqueness: true
  before_save {self.likes_count = 0}
  def self.last_instagram_id(hashtag)
    (Image.select(:service_id).where(provider: 'instagram', hashtag_id: hashtag).count > 0 ? Image.select(:service_id).where(provider: 'instagram').last.service_id : Instagram.tag_recent_media(hashtag.tag).data.first.created_time).to_i * 1000
  end
end
class Hashtag < ActiveRecord::Base
  attr_accessible :tag, :start_time, :images
  has_many :images

  def self.active
    Hashtag.where('start_time < ?', Time.now).order('"start_time" DESC').first
  end
end
class Auth < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :data, :url, :images, :is_subscribed, :accepted_deal, :images, :own_images, :avatar_url
  has_many :own_images, class_name: :Image, foreign_key: :author_id
  validates_uniqueness_of :uid, scope: :provider
  validates_uniqueness_of :url, scope: :provider
end
require 'instagram'
Instagram.configure do |config|
  config.client_id = "66f96c768dd64b8887d10ae2feb6d1d6"
  config.client_secret = "1906cbd03e674cca92a4480e7bb64adb"
end

@tag = Hashtag.active
start_time = @tag.start_time.to_i.to_s

parse = lambda { |start_id = 123456789012345|
  answer = Instagram.tag_recent_media(@tag.tag, max_tag_id: start_id, min_tag_id: Image.last_instagram_id(@tag))
  parse.call(answer.pagination.next_max_tag_id.to_i) if answer.pagination.next_max_tag_id.to_i > Image.last_instagram_id(@tag) and answer.data.last.created_time > start_time
  answer.data.each { |status|
    @tag.images.create(
        provider: 'instagram',
        image_link: status.images.standard_resolution.url,
        post_url: status.link,
        auth: Auth.find_by_uid(status.user.id) || Auth.create(uid: status.user.id, name: status.user.screen_name || status.user.username, url: %(http://instagram.com/#{status.user.username}), provider: "instagram", avatar_url: status.user.profile_picture),
        service_id: status.created_time.to_i,
        text: status.text
    )
  } if answer.data.count > 0
}
require 'daemons'
Daemons.daemonize
loop {
  parse.call
  sleep 30
}