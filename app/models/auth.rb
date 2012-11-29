# -*- encoding : utf-8 -*-
class Auth < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :data, :url, :images, :is_subscribed, :accepted_deal, :images, :own_images
  has_many :own_images, class_name: :Image, foreign_key: :author_id
  has_and_belongs_to_many :images, uniq: true
  scope :twi, where(provider: "twitter")
  scope :fb, where(provider: "facebook")
  scope :ig, where(provider: "instagram")
  validates :accepted_deal, acceptance: true, unless: Proc.new {email.blank?}
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
end
