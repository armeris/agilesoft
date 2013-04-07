class BlogsTags < ActiveRecord::Migration
  def change
    create_table :blogs_tags do |t|
      t.references :blog_id
      t.references :tag_id
    end
  end
end
