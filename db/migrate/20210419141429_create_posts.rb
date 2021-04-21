class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
