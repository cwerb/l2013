# -*- encoding : utf-8 -*-
class Auth < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :data
  scope :twi, where(provider: "twitter")
  scope :vk, where(provider: "vkontakte")
  scope :ig, where(provider: "instagram")
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
end
