class InstagramController < ApplicationController
  def callback
    if params.has_key? 'hub.challenge'
      render text: params['hub.challenge']
    elsif params.has_key? '_json'
      if options[:signature] == OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), Instagram.client_secret, params[:body])
         tag = Hashtag.active
         media = Instagram.tag_recent_media tag.tag, min_id: Image.last_instagram_id
         media.data.each do |m|
           tag.images.create(
               image_link: images.standard_resolution.url,
               post_url: link,
               provider: 'facebook',
               service_id: created_time.to_i
           )
         end
      end
    end
  end
end
