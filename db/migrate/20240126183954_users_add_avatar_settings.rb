class UsersAddAvatarSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :avatar_settings, :jsonb, default: {}, null: false
  end
end
