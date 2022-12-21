# frozen_string_literal: true

module MostArticles
  extend ActiveSupport::Concern
  def most_commented(old_articles)
    articles = []
    old_articles.order(created_at: :asc).each do |article|
      if old_articles.all.map(&:comments_count).max(5).include?(article.comments_count)
        articles << Article.find_by(id: article.id)
      end
      return articles if articles.size == 5
    end
  end
end
