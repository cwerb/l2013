# -*- encoding : utf-8 -*-
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
        h2 %(Статистика сайта:)
        h4 %(Всего пользователей сайта: #{Auth.count})
        h4 %(Всего запостивших хрень с хэштегом: #{Auth.unscoped.count})
        h4 %(Всего смешных картинок: #{Image.count})
        h4 %(Всего смешных картинок с текущим хэштегом: #{Hashtag.active.images.count})
      end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
