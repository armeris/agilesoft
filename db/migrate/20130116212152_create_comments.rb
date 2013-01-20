class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.text :content
      t.references :blog
      t.boolean :deleted

      t.timestamps
    end
    add_index :comments, :blog_id
  end
end
