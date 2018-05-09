require 'rails_helper'

RSpec.describe Podcast, type: :model do
  it 'should be valid with valid attributes' do
  	podcast = FactoryBot.build(:podcast)
  	expect(podcast).to be_valid
  end

  it 'is not valid without a title' do
  	podcast = FactoryBot.build(:podcast, :title => nil)
  	expect(podcast).to_not be_valid
  end

  it 'is not valid without a description' do
  	podcast = FactoryBot.build(:podcast, :description => nil)
  	expect(podcast).to_not be_valid
  end

  it 'is not valid without an image' do
  	podcast = FactoryBot.build(:podcast, :image => nil)
  	expect(podcast).to_not be_valid
  end
end
