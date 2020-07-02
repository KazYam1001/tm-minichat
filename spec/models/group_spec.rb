require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }
  end
end
