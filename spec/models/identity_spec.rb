require 'rails_helper'

RSpec.describe Identity, type: :model do
  it 'should be valid with valid attributes' do
  	FactoryBot.build(:identity).tap do |identity|
  		expect(identity).to be_valid
  	end
  end

  it 'is not valid without a uid' do
  	FactoryBot.build(:identity, :uid => nil).tap do |identity|
  		expect(identity).to_not be_valid
  	end
  end

  it 'is not valid without a provider' do
  	FactoryBot.build(:identity, :provider => nil).tap do |identity|
  		expect(identity).to_not be_valid
  	end
  end
end
