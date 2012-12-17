# -*- encoding : utf-8 -*-
ActiveAdmin.register Image do
  menu :priority => 3, :label => "Используемые изображения"
  filter :created_at, label: 'дата публикации'
  filter :provider, as: :select, collection: proc {%w(facebook twitter instagram)}, label: "соцсеть"
  filter :likes_count, label: 'количество лайков'
  actions :index
  batch_action :destroy, false
  batch_action :Заблокировать do |selection|
    Image.find(selection).each do |i|
      i.is_blocked = true
      i.save
    end
    redirect_to admin_images_path
  end
  batch_action :Разблокировать do |selection|
    Image.find(selection).each do |i|
      i.is_blocked = false
      i.save
    end
    redirect_to admin_images_path
  end

  index title: "Используемые изображения", as: :grid, columns: 5 do |image|
    @not_liked_image_count = 0 if @not_liked_image_count.nil?
    resource_selection_cell image
    div class: %(imagepic #{"image-blocked" if image.is_blocked}) do
        img src: image.image_link
    end
    h4 %(Лайкнули уже #{image.likes_count})
  end
  end
