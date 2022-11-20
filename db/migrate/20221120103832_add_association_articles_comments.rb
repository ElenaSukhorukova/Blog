class AddAssociationArticlesComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :author_comment, foreign_key: { to_table: :users }
    add_reference :articles, :author_article, foreign_key: { to_table: :users }
  end
end
