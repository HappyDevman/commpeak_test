require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:text) }
  end

  describe 'Model associations' do
    it { is_expected.to belong_to(:ticket) }
  end
end
