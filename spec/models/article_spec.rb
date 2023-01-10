require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create(:article) }

  it 'returns article\'s content' do
    expect(article.content).to be_an_instance_of(String)
  end

  it 'returns article\'s title' do
    expect(article.title).to eq('Article\'s title')
  end

  describe 'validation' do
    it 'returns true for the body' do
      expect(article.title.present?).to be true
    end

    it 'returns true for the invalid article' do
      article.title = 'H'
      expect(article.invalid?).to be true
    end

    it 'returns true for the invalid article' do
      article.content = 'H'
      expect(article.invalid?).to be true
    end
  end
  
  describe 'association' do
    it 'belongs a user' do
      expect(article.user).to be_an_instance_of(User)
    end

    it { is_expected.to have_many :comments }
  end
end
