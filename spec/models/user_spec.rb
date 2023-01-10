require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'returns user\'s username' do
    expect(user.username).to eq('Walter White')
  end

  it 'returns user\'s email' do
    expect(user.email).to be_an_instance_of(String)
  end

  describe 'validation' do
    it 'returns true for the username' do
      expect(user.username.present?).to be true
    end
  end

  describe 'association' do   
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :articles }
  end
end
