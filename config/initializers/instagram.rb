# -*- encoding : utf-8 -*-
Instagram.configure do |config|
  config.client_id = "66f96c768dd64b8887d10ae2feb6d1d6"
  config.client_secret = "1906cbd03e674cca92a4480e7bb64adb"
end

Daemons.run_proc("instagram-parser", multiple: false, monitor: true) do
  start_time = Time.now.to_i.to_s
  tag = Hashtag.active
  while true do
    parse = lambda { |start_id = 123456789012345|
      answer = Instagram.tag_recent_media(tag.tag, max_tag_id: start_id, min_tag_id: Image.last_instagram_id)
      parse.call(answer.pagination.next_max_tag_id.to_i) if ((answer.pagination.next_max_tag_id.to_i > Image.last_instagram_id) and (answer.data.last.created_time > start_time))
      answer.data.each { |status|
        tag.images.create(
            provider: 'instagram',
            image_link: status.images.standard_resolution.url,
            post_url: status.link,
            auth: Auth.find_by_uid(status.user.id) || Auth.create(uid: status.user.id, name: status.user.screen_name),
            service_id: status.created_time.to_i
        )
      } if answer.data.count > 0
    }
    parse.call
    tag.save
    sleep 30
  end
end unless Rails.env.development?
