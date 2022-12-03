class Comment < ApplicationRecord
  include Visible
  include TimeShow
  
  validates :body, presence: true, length: { maximum: 4000 }
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
