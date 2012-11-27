class CreateAuthImages < ActiveRecord::Migration
  def change
    create_table :auth_images do |t|
      t.belongs_to :auth
      t.belongs_to :image
    end
  end
end
