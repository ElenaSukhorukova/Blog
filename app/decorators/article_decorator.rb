class ArticleDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
end
