class User < ApplicationRecord
  validates :username, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, foreign_key: :author_comment_id, dependent: :destroy
  has_many :articles, foreign_key: :author_article_id, dependent: :destroy
end
