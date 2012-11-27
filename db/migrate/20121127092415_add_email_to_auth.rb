class AddEmailToAuth < ActiveRecord::Migration
  def change
    add_column :auths, :email, :string

    add_column :auths, :is_subscribed, :boolean

  end
end
