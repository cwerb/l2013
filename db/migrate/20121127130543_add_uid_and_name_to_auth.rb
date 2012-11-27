class AddUidAndNameToAuth < ActiveRecord::Migration
  def change
    add_column :auths, :uid, :string,

    add_column :auths, :name, :string

  end
end
