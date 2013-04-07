class Blog < ActiveRecord::Base
	has_many :comments
	has_and_belongs_to_many :tags
  attr_accessible :author, :content, :title, :visible, :updated_at

  validates :author, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true
end
