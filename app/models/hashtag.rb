class Hashtag < ActiveRecord::Base
  attr_accessible :tag, :start_time, :images
  has_many :images

  def self.active
    Hashtag.select(:tag).where('start_time < ?', Time.now).order('"start_time" DESC').first
  end
end
