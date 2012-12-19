class User < ActiveRecord::Base
  attr_accessible :avatar_url, :email, :name, :auths
  has_many :auths
end
