class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id1, null: false
      t.integer :user_id2, null: false
      t.timestamps
    end
      add_index :friendships, [:user_id1, :user_id2], unique: true
  end
end
