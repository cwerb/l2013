require 'daemons'
Daemons.new_proc 'tracker' do
require File.expand_path('../../config/environment', __FILE__)
require 'rubygems'
require 'active_record'

tag = HashTag.active
  TweetStream::Client.new.track('#'+tag.tag) do |status|
    status.media.each do |photo|
      tag.images.create(
          provider: 'twitter',
          image_link: photo.media_url,
          author_id: status.from_user,
          service_id: status.id
      )
    end
  end
end