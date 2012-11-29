class AddUrlToAuth < ActiveRecord::Migration
  def change
    add_column :auths, :url, :string
  end
end
