class Comment < ApplicationRecord
  include Visible
  include TimeShow

  validates :body, presence: true, length: { maximum: 4000 }

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  scope :pablic_private, -> { where.not(status: Comment::VALID_STATUES[2]).order(created_at: :desc) }
  scope :pablic, -> { where(status: Comment::VALID_STATUES[0]).order(created_at: :desc) }
end
