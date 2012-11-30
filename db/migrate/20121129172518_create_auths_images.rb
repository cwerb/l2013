# -*- encoding : utf-8 -*-
class CreateAuthsImages < ActiveRecord::Migration
  def change
    create_table :auths_images do |t|
      t.integer :auth_id
      t.integer :image_id
    end
  end
end
