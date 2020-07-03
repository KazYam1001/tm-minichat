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

  describe '#create (POST /api/groups)' do
    context '正常なパラメータの場合' do
      let(:valid_params) {{ name: 'group1' }}

      it 'groupsのレコードが1件増えること' do
        expect {
          post api_groups_path, params: valid_params
        }.to change(Group, :count).by(1)
      end
      it '正常なレスポンスを返すこと' do
        post api_groups_path, params: valid_params
        expect(response).to have_http_status(:success)
      end
    end

    context '不正なパラメータの場合' do
      let(:invalid_params) {{ name: nil }}

      it 'groupsのレコードが増えない' do
        expect {
          post api_groups_path, params: invalid_params
        }.to_not change(Group, :count)
      end
    end
  end
end
