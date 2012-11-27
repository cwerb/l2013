class Hashtag < ActiveRecord::Base
  attr_accessible :tag, :start_time
  scope :active, lambda { where('start_time < ?', Time.now).order('"start_time" DESC').first }
end
