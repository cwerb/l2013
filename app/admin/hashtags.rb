# -*- encoding : utf-8 -*-
ActiveAdmin.register Hashtag do
  menu :priority => 22, :label => "Действующие хэштэги"
  config.filters = false
  actions :index, :edit, :update, :delete

  index title: "Хэштэги" do
    column "#тэг", :tag
    column "Начало действия тэга", :start_time
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :tag, label: "Тэг"
      f.input :start_time, as: :datepicker, label: "Дата начала действия"
    end
    f.buttons
  end
end
