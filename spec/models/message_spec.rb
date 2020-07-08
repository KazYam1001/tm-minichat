require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validation' do
    context 'valid' do
      it 'ファクトリを使って正常に保存できる' do
        message = build(:message)
        expect(message).to be_valid
      end
    end

    context 'invalid' do
      it 'contentが空では保存できない' do
        message = build(:message, content: '')
        expect(message).to be_invalid
      end
    end
  end
end
