# -*- encoding : utf-8 -*-
class AddUrlToAuth < ActiveRecord::Migration
  def change
    add_column :auths, :url, :string
  end
end
