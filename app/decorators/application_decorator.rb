class ApplicationDecorator < Draper::Decorator
  def formatted_created_at
    I18n.l(created_at, format: '%B %Y')
  end
end
