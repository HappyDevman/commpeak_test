require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Model associations' do
    it { is_expected.to have_many(:tickets) }
  end
end
