class AddServiceTimeToImage < ActiveRecord::Migration
  def change
    add_column :images, :service_time, :string
    add_column :images, :datetime, :string
  end
end
