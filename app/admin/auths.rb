# -*- encoding : utf-8 -*-
ActiveAdmin.register Auth do
  menu :priority => 3, :label => "Авторизованные пользователи"
  actions :index
  filter :provider, as: :check_boxes, collection: proc {%w(facebook twitter instagram)}, label: "Социальная сеть"
  filter :created_at, label: "Дата регистрации"
  actions :index
  filter :email
  index title: "Авторизованные пользователи" do
    column :provider
    column :email
    column :name
    column :url
  end


  controller do
    def scoped_collection
      Auth.registred
    end
  end
end
