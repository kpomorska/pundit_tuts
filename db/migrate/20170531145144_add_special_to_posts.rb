class AddSpecialToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :special, :boolean, default: false
  end
end
