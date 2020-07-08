require 'rails_helper'

RSpec.describe "Api::Messages", type: :request do

  describe "#index (GET /api/groups/:group_id/messages)" do
    let(:group) { create(:group) }

    it "正常なレスポンスを返す" do
      create_list(:message, 10)
      create_list(:message, 5, group: group)

      get api_group_messages_path(group)
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json.length).to eq 5
    end
  end

  describe "#create (POST /api/groups/:group_id/messages)", focus: true do
    let(:group) { create(:group) }

    context 'valid params' do
      let(:valid_params) {{ content: 'some messages' }}

      it "メッセージが1件増え、正常なレスポンスを返す" do
        expect {
          post api_group_messages_path(group), params: valid_params
        }.to change(Message, :count).by(1)

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['content']).to eq 'some messages'
        expect(json['group_id']).to eq group.id
      end
    end

    context 'invalid params' do
      let(:invalid_params) {{ content: '' }}

      it 'メッセージが増えない' do
        expect {
          post api_group_messages_path(group), params: invalid_params
        }.to_not change(Message, :count)
      end
    end

  end
end
