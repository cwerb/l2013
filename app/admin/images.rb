# -*- encoding : utf-8 -*-
ActiveAdmin.register Image do
  filter :created_at, label: 'дата публикации'
  filter :provider, as: :select, collection: proc {%w(facebook twitter instagram)}, label: "соцсеть"
  filter :likes_count, label: 'количество лайков'
  index as: :block do |image|
    div for: image do
      div do
        link_to image_tag(image.image_link), image.post_url
      end
    end
  end
end
