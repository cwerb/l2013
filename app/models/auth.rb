# -*- encoding : utf-8 -*-
class Auth < ActiveRecord::Base
  scope :registred, -> {where('"email" NOTNULL')}
  attr_accessible :provider, :uid, :name, :data, :url, :images, :is_subscribed, :accepted_deal, :images, :own_images, :avatar_url
  has_many :own_images, class_name: :Image, foreign_key: :author_id
  serialize :data
  has_and_belongs_to_many :images, uniq: true
  validates_uniqueness_of :uid, scope: :provider
  validates_uniqueness_of :url, scope: :provider
  validates_acceptance_of :accepted_deal, if: Proc.new {params[:action] == :final_stage}
end
