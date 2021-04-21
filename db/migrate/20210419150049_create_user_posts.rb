class CreateUserPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_posts do |t|
      t.integer :post_id
      t.integer :user_id
      t.integer :created_by

      t.timestamps
    end
  end
end
