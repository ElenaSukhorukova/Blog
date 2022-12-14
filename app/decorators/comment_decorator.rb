class CommentDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
end
