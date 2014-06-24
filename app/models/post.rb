class Post < ActiveRecord::Base

  include Voteable, Sluggable

  belongs_to :creator, foreign_key: :user_id, class_name: "User"
  has_many :comments
  has_and_belongs_to_many :categories

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validates :categories, presence: true

  sluggable_column :title

end