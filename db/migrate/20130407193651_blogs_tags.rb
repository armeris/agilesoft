class BlogsTags < ActiveRecord::Migration
  def change
    create_table :blogs_tags, :id => false do |t|
      t.references :blog
      t.references :tag
    end
  end
end