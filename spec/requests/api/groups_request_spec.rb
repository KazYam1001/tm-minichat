require 'rails_helper'

RSpec.describe "Api::Groups", type: :request do
  describe '#index (GET /api/groups)' do
    it '/api/groups を叩くと正常なレスポンスを返す' do
      # 事前に10件用意する
      create_list(:group, 10)

      get api_groups_path
      # 後でデータ件数を数えたいのでresponse.bodyを加工しておく
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      # ちゃんと全件取得しているか
      expect(json.length).to eq(10)
    end
  end
end
