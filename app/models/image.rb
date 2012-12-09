# -*- encoding : utf-8 -*-
class Image < ActiveRecord::Base
  attr_accessible :image_link, :likes_count, :created_at, :provider, :service_id, :hashtag, :post_url, :auth, :likes_count
  belongs_to :hashtag
  belongs_to :auth, foreign_key: :author_id
  has_and_belongs_to_many :auths, uniq: true
  before_create {self.likes_count = 0}
  validates :provider, presence: true
  validates_uniqueness_of :service_id, scope: :provider
  validates :post_url, uniqueness: true
  validates :image_link, uniqueness: true
end
