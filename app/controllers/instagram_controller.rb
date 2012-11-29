# -*- encoding : utf-8 -*-
class InstagramController < ApplicationController
  def callback
    if params.has_key? 'hub.challenge'
      render text: params['hub.challenge']
    elsif params.has_key? 'instagram'
      tag = Hashtag.active
      media = Instagram.tag_recent_media tag.tag, min_id: Image.last_instagram_id
      media.data.each do |photo|
        tag.images.create(
            provider: 'instagram',
            image_link: photo.images.standard_resolution.url,
            post_url: photo.link,
            auth: Auth.find_by_uid(status.user.id) || Auth.create(uid: status.user.id, name: status.user.screen_name),
            service_id: photo.created_time.to_i
        )
      end
      render nothing: true
    end
  end
end
