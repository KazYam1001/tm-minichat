require 'rails_helper'

RSpec.describe "Api::Groups", type: :request do
  describe '#index (GET /api/groups)' do
    it 'groupsのレコード全てを返す' do
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

  describe '#show (GET /api/groups/:id)' do
    let(:group) { create(:group) }

    it '期待したgroupsのレコード1件を返す' do
      get api_group_path(group)

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      # 取得したグループが事前に作ったグループと同じか
      expect(json['id']).to eq(group.id)
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

  describe '#update (PUT /api/groups/:id)' do
    let(:group) { create(:group, name: 'default_name') }

    context '正常なパラメータの場合' do
      let(:valid_params) {{ name: 'changed_name' }}

      it 'グループ名が更新されること' do
        put api_group_path(group), params: valid_params

        expect(group.reload.name).to eq 'changed_name'
      end

      it '正常なレスポンスを返すこと' do
        post api_groups_path(group), params: valid_params

        expect(response).to have_http_status(:success)
      end
    end

    context '異常なパラメータの場合' do
      let(:invalid_params) {{ name: nil }}

      it 'グループ名が更新されないこと' do
        put api_group_path(group), params: invalid_params

        expect(group.reload.name).to eq 'default_name'
      end
    end
  end

  describe '#destroy (DELETE /api/groups/:id)' do
    it 'groupsのレコードが1件減り、削除したgroupのidを返すこと' do
      group = create(:group)

      expect {
        delete api_group_path(group)
      }.to change(Group, :count).by(-1)

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json['id']).to eq group.id.to_s
    end
  end
end
