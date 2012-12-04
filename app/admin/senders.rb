# -*- encoding : utf-8 -*-
ActiveAdmin.register Auth, as: "poster" do
  menu :priority => 7, :label => "Посмотрите, это они сделали ЭТО!"
  filter :provider, as: :check_boxes, collection: proc {%w(facebook twitter instagram)}, label: "Социальная сеть"
  filter :created_at, label: "Дата обнаружения"
  filter :name, label: "имени"
  filter :url
  actions :index, :show


  batch_action :destroy, false
  batch_action :Заблокировать do |selection|
    Auth.find(selection).each do |i|
      i.is_blocked = true
      i.save
    end
    redirect_to admin_poster_path
  end
  batch_action :Разблокировать do |selection|
    Auth.find(selection).each do |i|
      i.is_blocked = false
      i.save
    end
    redirect_to admin_poster_path
  end


  index title: "Участники конкурса" do
    selectable_column
    column :id
    column "Соцсеть", :provider
    column "Дата первого проявления", :created_at
    column "ID соцсети", :uid
    column "Имя", :name
    column "Ссылка на профиль", :url do |user|
      link_to user.url, user.url
    end
    column "Просмотреть фото пользователя", :view do |user|
     link_to "смотреть", admin_poster_path(user.id)
    end
  end

  show do |user|
    h4 %(Этот пользователь запостил #{user.own_images.count} фото с хэштегом:)
    not_liked_image_count = 0
    user.own_images.all.each do |image|
      div class: %(image #{"image-blocked" if image.is_blocked}) do
        img src: image.image_link
        h4 %(Фото набрало #{image.likes_count} лайков)
      end
    end
  end
end
