class AddColdToUser < ActiveRecord::Migration
  def change
    add_column :users, :cold, :boolean
  end
end
