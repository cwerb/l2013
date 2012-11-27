class InstagramController < ApplicationController
  def callback
    if params.has_key? 'hub.challenge'
      render text: params['hub.challenge']
    else
      Instagram.process_subscription params[:body] do |handler|
        handler.on_tag_changed do |tag_id, data|
          puts [tag_id, data]
        end
      end
    end
  end
end
