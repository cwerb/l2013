# -*- encoding : utf-8 -*-
class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :tag
      t.datetime :start_time

      t.timestamps
    end
  end
end
