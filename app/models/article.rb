class Article < ApplicationRecord
  include Visible

  validates :title, presence: true, length: { minimum: 2 }
  validates :content, presence: true, length: { minimum: 2 }

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :pablic_private, -> { pablic_private }, class_name: 'Comment'
  has_many :pablic, -> { pablic }, class_name: 'Comment'

  belongs_to :user

  def comments_count
    self.comments.count
  end

  scope :pablic_private, -> { where.not(status: Article::VALID_STATUES[2]).order(created_at: :desc) }
  scope :pablic, -> { where(status: Article::VALID_STATUES[0]).order(created_at: :desc) }
  scope :archived, -> { where(status: Article::VALID_STATUES[2]).order(created_at: :desc) }
end