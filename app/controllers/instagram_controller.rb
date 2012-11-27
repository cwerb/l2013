class InstagramController < ApplicationController
  def callback
    if params['hub.challenge']
      render text: params['hub.challenge']
    elsif params[:_json]
      Instagram.process_subscription params[:_json] do |handler|
        handler.on_tag_changed do |tag_id, data|
          raise [tag_id, data]
        end
      end
    end
  end
end
