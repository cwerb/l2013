# -*- encoding : utf-8 -*-
class InstagramController < ApplicationController
  def callback
    if params.has_key? 'hub.challenge'
      render text: params['hub.challenge']
    elsif params.has_key? 'instagram'
      tag = Hashtag.active
      media = Instagram.tag_recent_media tag.tag, min_id: Image.last_instagram_id
      media.data.each do |m|
        tag.images.create(
            image_link: m.images.standard_resolution.url,
            post_url: m.link,
            author_id: m.user.id,
            provider: 'instagram',
            service_id: m.created_time.to_i
        )
      end
      render nothing: true
    end
  end
end
