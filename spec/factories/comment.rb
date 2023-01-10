FactoryBot.define do
  factory :comment do
    user { User.take || create(:user) }
    body { 'Comment\'s body' }
    status { Comment::VALID_STATUES.sample }
    association :commentable, factory: :article
  end
end
