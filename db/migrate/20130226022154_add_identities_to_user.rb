class AddIdentitiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :email, :string
    add_column :users, :github, :string
  end
end
