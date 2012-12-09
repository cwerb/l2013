class AddAvatarUrlToAuth < ActiveRecord::Migration
  def change
    add_column :auths, :avatar_url, :string
  end
end
