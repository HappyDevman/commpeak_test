require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Model associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end
end
