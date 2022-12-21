# frozen_string_literal: true

class ArticleDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
end
