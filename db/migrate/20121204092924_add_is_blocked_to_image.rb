class AddIsBlockedToImage < ActiveRecord::Migration
  def change
    add_column :images, :is_blocked, :boolean
  end
end
