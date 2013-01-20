class Blog < ActiveRecord::Base
	has_many :comments
  attr_accessible :author, :content, :title, :visible, :updated_at

  validates :author, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true
end
