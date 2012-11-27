# -*- encoding : utf-8 -*-
class AddServiceIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :service_id, :string

  end
end
