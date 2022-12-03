class Article < ApplicationRecord
  include Visible
  include TimeShow

  validates :title, presence: true, length: { minimum: 2 }
  validates :content, presence: true, length: { minimum: 2 }

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
end