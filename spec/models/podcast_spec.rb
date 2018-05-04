require 'rails_helper'

RSpec.describe Podcast, type: :model do
  it 'should be valid with valid attributes' do
  	podcast = FactoryBot.build(:podcast)
  	expect(podcast).to be_valid
  end
end
