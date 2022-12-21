# frozen_string_literal: true

class Article < ApplicationRecord
  include Visible

  validates :title, presence: true, length: { minimum: 2 }
  validates :content, presence: true, length: { minimum: 2 }

  has_many :comments, as: :commentable, dependent: :destroy
  has_many(:pablic_private, -> { pablic_private },
           inverse_of: :comment,
           dependent: :destroy)
  has_many(:pablic, -> { pablic },
           inverse_of: :comment,
           dependent: :destroy)

  belongs_to :user

  delegate :count, to: :comments, prefix: true

  scope :pablic_private, -> { where.not(status: Article::VALID_STATUES[2]).order(created_at: :desc) }
  scope :pablic, -> { where(status: Article::VALID_STATUES[0]).order(created_at: :desc) }
  scope :archived, -> { where(status: Article::VALID_STATUES[2]).order(created_at: :desc) }
end
