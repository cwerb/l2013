class AddProviderToImage < ActiveRecord::Migration
  def change
    add_column :images, :provider, :string

  end
end
