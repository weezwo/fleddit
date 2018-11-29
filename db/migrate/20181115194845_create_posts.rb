class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.integer :author_id
      t.boolean :edited?

      t.timestamps
    end
  end
end
