class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :author
      t.string :title
      t.text :content
      t.boolean :visible

      t.timestamps
    end
  end
end
