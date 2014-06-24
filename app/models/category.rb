class Category < ActiveRecord::Base

  include Sluggable
  
  has_and_belongs_to_many :posts
  validates :name, presence: true
  validates :name, uniqueness: true

  sluggable_column :name

end