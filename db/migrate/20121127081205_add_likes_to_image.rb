class AddLikesToImage < ActiveRecord::Migration
  def change
    add_column :images, :likes_count, :integer

  end
end
