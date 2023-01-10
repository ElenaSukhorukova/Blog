require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  it 'returns comment\'s body' do
    expect(comment.body).to eq('Comment\'s body')
    expect(comment.body).to be_an_instance_of(String)
  end

  describe 'validation' do
    it 'returns true for the body' do
      expect(comment.body.present?).to be true
    end

    it 'returns true for the invalid comment' do
      comment.body = Faker::Alphanumeric.alpha(number: 4001)
      expect(comment.invalid?).to be true
    end
  end

  describe 'association' do
    it 'belongs a user' do
      expect(comment.user).to be_an_instance_of(User)
    end

    it 'belongs an article' do
      expect(comment.commentable).to be_an_instance_of(Article)
    end
  end
end
