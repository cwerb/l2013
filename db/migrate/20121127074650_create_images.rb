# -*- encoding : utf-8 -*-
class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_link
      t.string :post_url
      t.belongs_to :hashtag

      t.timestamps
    end
  end
end
