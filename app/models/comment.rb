class Comment < ApplicationRecord
  include Visible
  
  validates :body, presence: true, length: { maximum: 4000 }
  
  belongs_to :author_comment , class_name: "User", optional: true
  belongs_to :commentable, polymorphic: true
end
