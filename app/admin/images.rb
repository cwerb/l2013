# -*- encoding : utf-8 -*-
ActiveAdmin.register Image do
  menu :priority => 3, :label => "Зохваченные картинки"
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

  index title: "Зохваченные картинки", as: :grid, columns: 5 do |image|
    @not_liked_image_count = 0 if @not_liked_image_count.nil?
    resource_selection_cell image
    div class: %(imagepic #{"image-blocked" if image.is_blocked}) do
        img src: image.image_link
    end
    h4 (image.likes_count > 0 ? %(Лайкнули уже #{image.likes_count}) : case @not_liked_image_count += 1
                                                                         when 1
                                                                           "Никто еще не любит эту фоточку"
                                                                         when 2
                                                                           "И эту тоже"
                                                                         when 3
                                                                           "И даже эту"
                                                                         when 4
                                                                           "Похоже, много фоточек тут говно"
                                                                         when 5
                                                                            "Даже продолжать не хочу"
                                                                         when 6
                                                                            "И не буду. Как будет хорошая фоточка - скажу"
                                                                         else
                                                                            ""
                                                                      end
                                                                         )
  end
  end
