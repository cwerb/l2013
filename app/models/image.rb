class Image < ActiveRecord::Base
  attr_accessible :image_link, :likes_count
  belongs_to :hashtag
  belongs_to :auth
  has_and_belongs_to_many :auths, uniq: true, after_add: [:update_likes, Proc.new {likes_count += 1}]

end
