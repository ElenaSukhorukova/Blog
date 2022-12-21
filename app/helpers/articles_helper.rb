# frozen_string_literal: true

module ArticlesHelper
  def count_comments(article)
    return article.comments.where.not(status: Article::VALID_STATUES[2]).count if current_user

    article.comments.where(status: Article::VALID_STATUES[0]).count
  end

  def anchor(article)
    visible = user_signed_in? ? article.comments.pablic_private : article.comments.pablic
    dom_id(visible.first)
  end
end
