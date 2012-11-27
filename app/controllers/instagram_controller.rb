class InstagramController < ApplicationController
  def callback
    render text: params['hub.challenge'] if get?
    if post?
      Instagram.process_subscription params[:_json] do |handler|
        handler.on_tag_changed do |tag_id, data|
          puts tag_id
          puts data
        end
      end
    end
  end
end
