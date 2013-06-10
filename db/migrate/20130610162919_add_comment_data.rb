class AddCommentData < ActiveRecord::Migration
  def up
  	add_column :comments, :remote_ip, :string
  	add_column :comments, :user_agent, :string
  	add_column :comments, :referrer, :string
  end

  def down
  	remove_column :comments, :remote_ip
  	remove_column :comments, :user_agent
  	remove_column :comments, :referrer
  end
end
