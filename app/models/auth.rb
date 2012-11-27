class Auth < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :data
end
