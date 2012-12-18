class AddTextToImage < ActiveRecord::Migration
  def change
    add_column :images, :text, :text
  end
end
