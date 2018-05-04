require 'rails_helper'

RSpec.describe User, type: :model do

  it 'should be valid with valid attributes' do
  	user = FactoryBot.build(:user)
  	expect(user).to be_valid
  end

  it 'is not valid without a username' do
  	user = FactoryBot.build(:user, :username => nil)
  	expect(user).to_not be_valid
  end

  it 'is not valid without an email' do
  	user = FactoryBot.build(:user, :email => nil)
  	expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
  	user = FactoryBot.build(:user, :password => nil)
  	expect(user).to_not be_valid
  end

  it 'is not valid without a password confirmation' do
  	user = FactoryBot.build(:user, :password_confirmation => nil)
  	expect(user).to_not be_valid
  end

  it 'is not valid without a role' do
  	user = FactoryBot.build(:user, :type => nil)
  	expect(user).to_not be_valid
  end

end
