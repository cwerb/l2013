# -*- encoding : utf-8 -*-
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc { I18n.t("active_admin.dashboard") }

  content :title => proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Прямо сейчас" do
          ul do
            li raw %(Хэштег сейчас: <b>##{Hashtag.active.tag}</b>)
            li raw %(Всего пользователей сайта: <b>#{Auth.registred.count}</b>)
            li raw %(Всего запостивших с хэштегом: <b>#{Auth.count}</b>)
            li raw %(Всего изображений: <b>#{Image.count}</b>)
            li raw %(Всего изображений с текущим хэштегом: <b>#{Hashtag.active.images.count}</b>)
          end
        end
      end
        column do
          panel "В топе", class: "imagepanel" do
            Auth.unscoped do
              ul class: "thumbnails" do
                Image.order('"likes_count" DESC').limit(10).map do |pic|
                  li class: "span4" do
                    img src: pic.image_link, class: "top-image"
                    h4 pic.likes_count, class: "top-image-likes-count"
                  end
                end
              end
            end
          end
        end
      end
    end # content
  end
