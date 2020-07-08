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

end
