FactoryBot.define do
  factory :article do
    user { User.take || create(:user) }
    title { 'Article\'s title' }
    content { 'Article\'s content' }
    status { Article::VALID_STATUES.sample }
  end
end
