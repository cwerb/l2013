# -*- encoding : utf-8 -*-
ActiveAdmin.register Auth do
  filter :provider, as: :select, collection: proc {%w(facebook twitter instagram)}, label: "соцсеть"
  filter :created_at
  index do
    column :provider
    column :name
    column :url
  end
end
