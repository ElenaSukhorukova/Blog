# frozen_string_literal: true

class AddAssociationArticlesComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, foreign_key: true
    add_reference :articles, :user, foreign_key: true
  end
end
