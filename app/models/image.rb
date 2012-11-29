# -*- encoding : utf-8 -*-
class Image < ActiveRecord::Base
  attr_accessible :image_link, :likes_count, :created_at, :provider, :service_id, :hashtag, :post_url, :auth
  belongs_to :hashtag
  belongs_to :auth, foreign_key: :author_id
  has_and_belongs_to_many :auths, uniq: true, after_add: [:update_likes, Proc.new {likes_count += 1}]
  before_save {likes_count = 0}
  validates :provider, presence: true
  validates_uniqueness_of :service_id, scope: :provider
  validates :post_url, uniqueness: true
  validates :image_link, uniqueness: true

  def self.last_instagram_id
    (Image.select(:service_id).where(provider: 'instagram').count > 0? Image.select(:service_id).where(provider: 'instagram').last.service_id : Instagram.tag_recent_media(Hashtag.active.tag).data.first.created_time.to_i) * 1000
  end
end
